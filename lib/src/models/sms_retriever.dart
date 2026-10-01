part of '../pinput.dart';

/// An interface for retrieving sms code. Used for SMS autofill.
/// You, as a developer should implement this interface.
///
/// [Pinput] calls [getSmsCode] once when it starts listening and calls [dispose] when it is removed
/// from the tree or when [Pinput.smsRetriever] is replaced.
abstract class SmsRetriever {
  /// This method should return the sms code.
  Future<String?> getSmsCode();

  /// Stops listening for sms and releases resources. Called by [Pinput].
  Future<void> dispose();
}

/// SmartAuth example (smart_auth 3.x):
// class SmsRetrieverImpl implements SmsRetriever {
//   const SmsRetrieverImpl(this.smartAuth);
//
//   final SmartAuth smartAuth;
//
//   @override
//   Future<void> dispose() async {
//     await smartAuth.removeSmsRetrieverApiListener();
//   }
//
//   @override
//   Future<String?> getSmsCode() async {
//     final res = await smartAuth.getSmsWithRetrieverApi();
//     return res.data?.code;
//   }
// }
//
// class SmartAuthExample extends StatefulWidget {
//   const SmartAuthExample({super.key});
//
//   @override
//   State<SmartAuthExample> createState() => _SmartAuthExampleState();
// }
//
// class _SmartAuthExampleState extends State<SmartAuthExample> {
//   late final SmsRetrieverImpl smsRetrieverImpl;
//
//   @override
//   void initState() {
//     super.initState();
//     smsRetrieverImpl = SmsRetrieverImpl(SmartAuth.instance);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Pinput(smsRetriever: smsRetrieverImpl);
//   }
// }
