import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) => pumpWidget(MaterialApp(home: Material(child: widget)));
}
