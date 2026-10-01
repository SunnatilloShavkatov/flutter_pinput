import 'package:flutter_pinput/flutter_pinput.dart';

class FakeSmsRetriever implements SmsRetriever {
  new(this.code, {this.delay = Duration.zero});

  final String? code;
  final Duration delay;
  int calls = 0;
  bool disposed = false;

  @override
  Future<String?> getSmsCode() async {
    calls++;
    if (delay > Duration.zero) {
      await Future<void>.delayed(delay);
    }
    return code;
  }

  @override
  Future<void> dispose() async => disposed = true;
}
