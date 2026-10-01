import 'package:flutter_pinput/flutter_pinput.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'helpers/helpers.dart';

void main() {
  testWidgets('switching between local and external controllers keeps value and listeners', (
    WidgetTester tester,
  ) async {
    final external = TextEditingController(text: '12');
    final changes = <String>[];
    Widget build(TextEditingController? controller) => Pinput(controller: controller, onChanged: changes.add);

    await tester.pumpApp(build(null));
    await tester.enterText(find.byType(EditableText), '1');

    await tester.pumpApp(build(external));
    external.text = '123';

    await tester.pumpApp(build(null));
    // The new local controller starts from the external controller's last value.
    expect(tester.widget<EditableText>(find.byType(EditableText)).controller.text, '123');
    await tester.enterText(find.byType(EditableText), '1234');

    // The detached external controller no longer drives Pinput.
    external.text = '9';

    expect(changes, ['1', '123', '1234']);
  });

  testWidgets('switching focusNode moves focus handling to the new node', (WidgetTester tester) async {
    final first = FocusNode();
    final second = FocusNode();

    await tester.pumpApp(Pinput(focusNode: first));
    await tester.pumpApp(Pinput(focusNode: second));
    await tester.tap(find.byType(Pinput));
    await tester.pump();

    expect(second.hasFocus, isTrue);
    expect(first.hasFocus, isFalse);
  });

  testWidgets('enabling a disabled Pinput makes it focusable again', (WidgetTester tester) async {
    final focusNode = FocusNode();

    await tester.pumpApp(Pinput(focusNode: focusNode, enabled: false));
    expect(focusNode.canRequestFocus, isFalse);

    await tester.pumpApp(Pinput(focusNode: focusNode));
    await tester.tap(find.byType(Pinput));
    await tester.pump();

    expect(focusNode.canRequestFocus, isTrue);
    expect(focusNode.hasFocus, isTrue);
  });

  testWidgets('restores the entered pin', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        restorationScopeId: 'app',
        home: Material(child: Pinput(restorationId: 'pin')),
      ),
    );

    await tester.enterText(find.byType(EditableText), '123');
    await tester.pump();
    await tester.restartAndRestore();

    expect(tester.widget<EditableText>(find.byType(EditableText)).controller.text, '123');
  });

  testWidgets('disposes smsRetriever when Pinput is removed', (WidgetTester tester) async {
    final retriever = FakeSmsRetriever(null);

    await tester.pumpApp(Pinput(smsRetriever: retriever));
    await tester.pumpWidget(const SizedBox());

    expect(retriever.disposed, isTrue);
  });

  testWidgets('ignores an SMS code of the wrong length', (WidgetTester tester) async {
    final controller = TextEditingController();

    await tester.pumpApp(Pinput(controller: controller, smsRetriever: FakeSmsRetriever('1234')));
    await tester.pump();

    expect(controller.text, isEmpty);
  });
}
