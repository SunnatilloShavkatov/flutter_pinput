import 'package:flutter_pinput/flutter_pinput.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'helpers/helpers.dart';

void main() {
  group('validator', () {
    testWidgets('shows the error after completion and hides it after a valid pin', (WidgetTester tester) async {
      await tester.pumpApp(Pinput(length: 4, validator: (pin) => pin == '2222' ? null : 'Wrong pin'));

      await tester.enterText(find.byType(EditableText), '1111');
      await tester.pump();
      expect(find.text('Wrong pin'), findsOneWidget);

      await tester.enterText(find.byType(EditableText), '2222');
      await tester.pump();
      expect(find.text('Wrong pin'), findsNothing);
    });

    testWidgets('hides the error while focused by default', (WidgetTester tester) async {
      await tester.pumpApp(Pinput(length: 4, closeKeyboardWhenCompleted: false, validator: (_) => 'Wrong pin'));

      await tester.enterText(find.byType(EditableText), '1111');
      await tester.pump();

      expect(find.text('Wrong pin'), findsNothing);
    });

    testWidgets('shows the error while focused when showErrorWhenFocused is true', (WidgetTester tester) async {
      await tester.pumpApp(
        Pinput(length: 4, closeKeyboardWhenCompleted: false, showErrorWhenFocused: true, validator: (_) => 'Wrong pin'),
      );

      await tester.enterText(find.byType(EditableText), '1111');
      await tester.pump();

      expect(find.text('Wrong pin'), findsOneWidget);
    });

    testWidgets('PinputAutovalidateMode.disabled validates only through Form', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpApp(
        Form(
          key: formKey,
          child: Pinput(
            length: 4,
            pinputAutovalidateMode: PinputAutovalidateMode.disabled,
            validator: (_) => 'Wrong pin',
          ),
        ),
      );

      await tester.enterText(find.byType(EditableText), '1111');
      await tester.pump();
      expect(find.text('Wrong pin'), findsNothing);

      expect(formKey.currentState!.validate(), isFalse);
      await tester.pump();
      expect(find.text('Wrong pin'), findsOneWidget);
    });

    testWidgets('Form.validate passes with a valid pin', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpApp(
        Form(
          key: formKey,
          child: Pinput(length: 4, validator: (pin) => pin == '2222' ? null : 'Wrong pin'),
        ),
      );

      await tester.enterText(find.byType(EditableText), '2222');
      await tester.pump();

      expect(formKey.currentState!.validate(), isTrue);
    });
  });

  group('forced error', () {
    testWidgets('shows errorText and applies errorPinTheme to every pin', (WidgetTester tester) async {
      const errorTheme = PinTheme(decoration: BoxDecoration(color: Colors.red));
      await tester.pumpApp(
        const Pinput(length: 4, forceErrorState: true, errorText: 'Server error', errorPinTheme: errorTheme),
      );

      expect(find.text('Server error'), findsOneWidget);
      expect(
        find.byWidgetPredicate((w) => w is AnimatedContainer && w.decoration == errorTheme.decoration),
        findsNWidgets(4),
      );
    });

    testWidgets('errorText alone does not show an error', (WidgetTester tester) async {
      await tester.pumpApp(const Pinput(errorText: 'Server error'));

      expect(find.text('Server error'), findsNothing);
    });

    testWidgets('errorBuilder replaces the default error widget', (WidgetTester tester) async {
      await tester.pumpApp(
        Pinput(
          forceErrorState: true,
          errorText: 'Server error',
          errorBuilder: (errorText, pin) => Text('custom: $errorText'),
        ),
      );

      expect(find.text('custom: Server error'), findsOneWidget);
      expect(find.text('Server error'), findsNothing);
    });
  });
}
