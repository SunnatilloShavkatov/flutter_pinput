import 'package:flutter_pinput/flutter_pinput.dart';
import 'package:material_ui/material_ui.dart';
import 'package:smart_auth/smart_auth.dart';

class SmsRetrieverImpl implements SmsRetriever {
  const new(this.smartAuth);

  final SmartAuth smartAuth;

  @override
  Future<void> dispose() => smartAuth.removeUserConsentApiListener();

  @override
  Future<String?> getSmsCode() async {
    final res = await smartAuth.getSmsWithUserConsentApi();
    return res.data?.code;
  }
}

class UserConsentApiExample extends StatefulWidget {
  const new({super.key});

  @override
  State<UserConsentApiExample> createState() => _UserConsentApiExampleState();
}

class _UserConsentApiExampleState extends State<UserConsentApiExample> {
  late final SmsRetrieverImpl smsRetrieverImpl;

  @override
  void initState() {
    smsRetrieverImpl = SmsRetrieverImpl(SmartAuth.instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Pinput(smsRetriever: smsRetrieverImpl);
}
