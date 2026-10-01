import 'package:flutter/services.dart';
import 'package:flutter_pinput/flutter_pinput.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'helpers/helpers.dart';

void main() {
  group('input', () {
    testWidgets('text is limited to length', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpApp(Pinput(controller: controller));

      await tester.enterText(find.byType(EditableText), '12345678');

      expect(controller.text, '123456');
    });

    testWidgets('inputFormatters run before the length limit', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpApp(Pinput(controller: controller, inputFormatters: [FilteringTextInputFormatter.digitsOnly]));

      await tester.enterText(find.byType(EditableText), '123-456');

      expect(controller.text, '123456');
    });

    testWidgets('obscureText shows obscuringCharacter instead of the pin', (WidgetTester tester) async {
      await tester.pumpApp(const Pinput(obscureText: true, obscuringCharacter: '*'));

      await tester.enterText(find.byType(EditableText), '12');
      await tester.pump();

      expect(find.text('*'), findsNWidgets(2));
      expect(find.text('1'), findsNothing);
      expect(find.text('2'), findsNothing);
    });

    testWidgets('obscuringWidget is shown for every entered pin', (WidgetTester tester) async {
      await tester.pumpApp(const Pinput(obscureText: true, obscuringWidget: FlutterLogo()));

      await tester.enterText(find.byType(EditableText), '123');
      await tester.pump();

      expect(find.byType(FlutterLogo), findsNWidgets(3));
    });

    testWidgets('separatorBuilder is called between pins', (WidgetTester tester) async {
      await tester.pumpApp(
        Pinput(length: 4, separatorBuilder: (index) => SizedBox(key: ValueKey('separator-$index'), width: 4)),
      );

      for (var i = 0; i < 3; i++) {
        expect(find.byKey(ValueKey('separator-$i')), findsOneWidget);
      }
      expect(find.byKey(const ValueKey('separator-3')), findsNothing);
    });
  });

  group('keyboard', () {
    testWidgets('closes the keyboard when completed', (WidgetTester tester) async {
      final focusNode = FocusNode();
      await tester.pumpApp(Pinput(length: 4, focusNode: focusNode));

      await tester.enterText(find.byType(EditableText), '1234');
      await tester.pump();

      expect(focusNode.hasFocus, isFalse);
    });

    testWidgets('keeps focus when closeKeyboardWhenCompleted is false', (WidgetTester tester) async {
      final focusNode = FocusNode();
      await tester.pumpApp(Pinput(length: 4, focusNode: focusNode, closeKeyboardWhenCompleted: false));

      await tester.enterText(find.byType(EditableText), '1234');
      await tester.pump();

      expect(focusNode.hasFocus, isTrue);
    });

    testWidgets('disabled Pinput cannot be focused and uses disabledPinTheme', (WidgetTester tester) async {
      final focusNode = FocusNode();
      const disabledTheme = PinTheme(decoration: BoxDecoration(color: Colors.grey));
      await tester.pumpApp(Pinput(length: 4, enabled: false, focusNode: focusNode, disabledPinTheme: disabledTheme));

      await tester.tap(find.byType(Pinput));
      await tester.pump();

      expect(focusNode.hasFocus, isFalse);
      expect(
        find.byWidgetPredicate((w) => w is AnimatedContainer && w.decoration == disabledTheme.decoration),
        findsNWidgets(4),
      );
    });

    testWidgets('custom keyboard: native input is read-only and controller drives the pins', (
      WidgetTester tester,
    ) async {
      final controller = TextEditingController();
      var completed = 0;
      await tester.pumpApp(
        Pinput(length: 4, controller: controller, useNativeKeyboard: false, onCompleted: (_) => completed++),
      );

      expect(tester.widget<EditableText>(find.byType(EditableText)).readOnly, isTrue);
      // The cursor is shown without focus so the user sees where the next digit goes.
      expect(find.text('|'), findsOneWidget);

      for (var i = 0; i < 6; i++) {
        controller.append('${i + 1}', 4);
      }
      await tester.pump();

      expect(controller.text, '1234');
      expect(completed, 1);

      controller.delete();
      await tester.pump();
      expect(controller.text, '123');
    });
  });

  group('onClipboardFound', () {
    late List<String> clipboardReads;

    setUp(() => clipboardReads = []);

    void mockClipboard(WidgetTester tester, String text) {
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
        if (call.method == 'Clipboard.getData') {
          clipboardReads.add(text);
          return <String, dynamic>{'text': text};
        }
        return null;
      });
      addTearDown(() => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, null));
    }

    testWidgets('is called when the clipboard holds a pin of the right length', (WidgetTester tester) async {
      mockClipboard(tester, '123456');
      String? found;
      await tester.pumpApp(Pinput(onClipboardFound: (value) => found = value));
      await tester.pump();

      expect(found, '123456');
    });

    testWidgets('is not called for a clipboard of a different length', (WidgetTester tester) async {
      mockClipboard(tester, '12345');
      String? found;
      await tester.pumpApp(Pinput(onClipboardFound: (value) => found = value));
      await tester.pump();

      expect(clipboardReads, isNotEmpty);
      expect(found, isNull);
    });

    testWidgets('checks the clipboard again when the app resumes', (WidgetTester tester) async {
      mockClipboard(tester, '123456');
      var calls = 0;
      await tester.pumpApp(Pinput(onClipboardFound: (_) => calls++));
      await tester.pump();

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();

      expect(calls, 2);
    });

    testWidgets('does not read the clipboard without onClipboardFound', (WidgetTester tester) async {
      mockClipboard(tester, '123456');
      await tester.pumpApp(const Pinput());
      await tester.pump();

      expect(clipboardReads, isEmpty);
    });
  });
}
