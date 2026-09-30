part of '../pinput.dart';

mixin _PinputUtilsMixin {
  void _maybeUseHaptic(HapticFeedbackType hapticFeedbackType) {
    switch (hapticFeedbackType) {
      case HapticFeedbackType.disabled:
        break;
      case HapticFeedbackType.lightImpact:
        HapticFeedback.lightImpact().ignore();
      case HapticFeedbackType.mediumImpact:
        HapticFeedback.mediumImpact().ignore();
      case HapticFeedbackType.heavyImpact:
        HapticFeedback.heavyImpact().ignore();
      case HapticFeedbackType.selectionClick:
        HapticFeedback.selectionClick().ignore();
      case HapticFeedbackType.vibrate:
        HapticFeedback.vibrate().ignore();
    }
  }

  Future<String> _getClipboardOrEmpty() async {
    final ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    return clipboardData?.text ?? '';
  }
}
