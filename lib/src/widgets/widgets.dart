part of '../pinput.dart';

/// Signature for a function that creates a widget for a given index, e.g., in a
/// list.
typedef JustIndexedWidgetBuilder = Widget Function(int index);

class _PinputFormField extends FormField<String> {
  const new({required super.validator, required super.enabled, required super.initialValue, required super.builder})
    : super(autovalidateMode: AutovalidateMode.disabled);
}

class _SeparatedRaw extends StatelessWidget {
  const new({required this.children, required this.mainAxisAlignment, this.separatorBuilder});

  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final JustIndexedWidgetBuilder? separatorBuilder;

  @override
  Widget build(BuildContext context) {
    final itemCount = max(0, children.length * 2 - 1);
    final indexedList = [for (int i = 0; i < itemCount; i += 1) i];
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisAlignment == MainAxisAlignment.center ? MainAxisSize.min : MainAxisSize.max,
      children: indexedList
          .map((index) {
            final itemIndex = index ~/ 2;
            return index.isEven ? children[itemIndex] : _separator(itemIndex);
          })
          .toList(growable: false),
    );
  }

  Widget _separator(int index) => separatorBuilder?.call(index) ?? PinputConstants._defaultSeparator;
}

class _PinputCursor extends StatelessWidget {
  const new({required this.textStyle, required this.cursor});

  final Widget? cursor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) => cursor ?? Text('|', style: textStyle);
}

class _PinputAnimatedCursor extends StatefulWidget {
  const new({required this.textStyle, required this.cursor});

  final Widget? cursor;
  final TextStyle? textStyle;

  @override
  State<_PinputAnimatedCursor> createState() => _PinputAnimatedCursorState();
}

// Blinks on a timer (like EditableText's caret) instead of a repeating AnimationController,
// so no frames are scheduled between blinks and `WidgetTester.pumpAndSettle` can settle.
class _PinputAnimatedCursorState extends State<_PinputAnimatedCursor> {
  static const Duration _blinkHalfPeriod = Duration(milliseconds: 500);
  static const Duration _fadeDuration = Duration(milliseconds: 250);

  late final Timer _timer;
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(_blinkHalfPeriod, (_) => setState(() => _visible = !_visible));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedOpacity(
    opacity: _visible ? 1 : 0,
    duration: _fadeDuration,
    child: _PinputCursor(textStyle: widget.textStyle, cursor: widget.cursor),
  );
}
