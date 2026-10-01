<div align="center">

<h1>Flutter pin code input</h1>

<h3>Need anything Flutter related? Reach out on <a href="https://www.linkedin.com/in/sunnatillo-shavkatov-430789216/">LinkedIn</a></h3>

[![Pub package](https://img.shields.io/pub/v/flutter_pinput.svg)](https://pub.dev/packages/flutter_pinput)
[![GitHub stars](https://img.shields.io/github/stars/SunnatilloShavkatov/flutter_pinput.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/SunnatilloShavkatov/flutter_pinput)
[![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

</div>

Flutter Pinput is an easy-to-use and customizable pin code input field. It supports animated
decoration switching, form validation, SMS autofill, custom cursor, copying from clipboard and more.
It also comes with beautiful examples you can choose from.

## Features

- Animated decoration switching
- Form validation
- SMS autofill on iOS
- SMS autofill on Android
- Standard cursor
- Custom cursor
- Cursor animation
- Copy from clipboard
- Ready for custom keyboard
- Standard paste option
- Obscuring character
- Obscuring widget
- Haptic feedback
- Close keyboard after completion
- Beautiful [examples](https://github.com/SunnatilloShavkatov/flutter_pinput/tree/master/example/lib)

## Installation

Requires Flutter `>=3.47.0` (Dart `>=3.13.0`).

```yaml
dependencies:
  flutter_pinput: ^2.0.0
  material_ui: ^1.5.0
```

```dart
import 'package:flutter_pinput/flutter_pinput.dart';
import 'package:material_ui/material_ui.dart';
```

## Migrating to 2.0.0

`flutter_pinput` 2.0.0 is built on the decoupled [`material_ui`](https://pub.dev/packages/material_ui)
and [`cupertino_ui`](https://pub.dev/packages/cupertino_ui) packages. They are separate copies of
`package:flutter/material.dart`, so `Pinput` only finds the `Material`, `Theme` and localizations
that come from `material_ui`.

1. Upgrade Flutter to `3.47` or newer.
2. Add `material_ui` to your `pubspec.yaml` and change
   `import 'package:flutter/material.dart';` to `import 'package:material_ui/material_ui.dart';`
   (see the [material_ui migration guide](https://pub.dev/packages/material_ui)).
3. If some of your dependencies still use `package:flutter/material.dart`, wrap your app with
   `MaterialUiCompatibilityBridge` via `MaterialApp.builder`.
4. Remove `hintLocales` if you passed it to `Pinput`.

Can't upgrade yet? Stay on `flutter_pinput: 1.0.3`.

## Demo

|                                                                 [Live Demo](https://rebrand.ly/6390b8)                                                                 |                                                      Rounded With Shadows                                                      |                                                      Rounded With Cursor                                                       |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------------------------:|
| <a href="https://rebrand.ly/6390b8"><img width="300" src="https://user-images.githubusercontent.com/26390946/155666045-aa93bf48-f8e7-407c-bb19-bc247d9e12bd.png"/></a> | <img width="300" src="https://user-images.githubusercontent.com/26390946/155599527-fe934f2c-5124-4754-bbf6-bb97d55a77c0.gif"/> | <img width="300" src="https://user-images.githubusercontent.com/26390946/155599870-03387689-7be2-4a30-8e6f-90136a0515be.gif"/> |

|                                                         Rounded Filled                                                         |                                                       With Bottom Cursor                                                       |                                                             Filled                                                             |
|:------------------------------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------------------------:|
| <img width="300" src="https://user-images.githubusercontent.com/26390946/155600099-d0a02f55-09e6-4142-92de-066cd71cf211.gif"/> | <img width="300" src="https://user-images.githubusercontent.com/26390946/155600276-0380b3b4-3d9c-4ea8-87d0-4f7ebd86e460.gif"/> | <img width="300" src="https://user-images.githubusercontent.com/26390946/155600427-901c1eae-e565-4cf8-a338-8ac40eb1149c.gif"/> |

## Getting Started

A pin has 6 states: `default`, `focused`, `submitted`, `following`, `disabled` and `error`.
You can customize each state with its own `PinTheme`. Pin smoothly animates from one state to
another automatically.

### `PinTheme`

| Property    | Type                 | Default |
|-------------|----------------------|:-------:|
| width       | `double`             | `56.0`  |
| height      | `double`             | `60.0`  |
| textStyle   | `TextStyle`          |    —    |
| decoration  | `BoxDecoration`      |    —    |
| margin      | `EdgeInsetsGeometry` |    —    |
| padding     | `EdgeInsetsGeometry` |    —    |
| constraints | `BoxConstraints`     |    —    |

Standard Pinput:

```dart
Widget buildPinput() {
  return Pinput(
    onCompleted: (pin) => debugPrint(pin),
  );
}
```

To customize it, create `defaultPinTheme` first:

```dart
const defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: TextStyle(
    fontSize: 20,
    color: Color.fromRGBO(30, 60, 87, 1),
    fontWeight: FontWeight.w600,
  ),
  decoration: BoxDecoration(
    border: Border.fromBorderSide(
      BorderSide(color: Color.fromRGBO(234, 239, 243, 1)),
    ),
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
);
```

If you want all pins to look the same, don't pass other themes. Otherwise create
`focusedPinTheme`, `submittedPinTheme`, `followingPinTheme` or `errorPinTheme` from
`defaultPinTheme`:

```dart
final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
  borderRadius: BorderRadius.circular(8),
);

final submittedPinTheme = defaultPinTheme.copyDecorationWith(
  color: const Color.fromRGBO(234, 239, 243, 1),
);
```

Put everything together:

```dart
Widget buildPinput() {
  const defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.fromBorderSide(
        BorderSide(color: Color.fromRGBO(234, 239, 243, 1)),
      ),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );

  final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
    borderRadius: BorderRadius.circular(8),
  );

  final submittedPinTheme = defaultPinTheme.copyDecorationWith(
    color: const Color.fromRGBO(234, 239, 243, 1),
  );

  return Pinput(
    defaultPinTheme: defaultPinTheme,
    focusedPinTheme: focusedPinTheme,
    submittedPinTheme: submittedPinTheme,
    validator: (pin) => pin == '2222' ? null : 'Pin is incorrect',
    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
    showCursor: true,
    onCompleted: (pin) => debugPrint(pin),
  );
}
```

## SMS Autofill

### iOS

Works out of the box — tap the code shown above the keyboard.

### Android

#### With `firebase_auth`

If you are using [firebase_auth](https://firebase.flutter.dev/docs/auth/phone#verificationcompleted),
set the controller's value in the `verificationCompleted` callback:

```
final pinController = TextEditingController();

Pinput(
  controller: pinController,
);

await FirebaseAuth.instance.verifyPhoneNumber(
  verificationCompleted: (PhoneAuthCredential credential) {
    pinController.setText(credential.smsCode!);
  },
  verificationFailed: (FirebaseAuthException e) {},
  codeSent: (String verificationId, int? resendToken) {},
  codeAutoRetrievalTimeout: (String verificationId) {},
);
```

#### Without `firebase_auth`

You have two options:
[SMS Retriever API](https://developers.google.com/identity/sms-retriever/overview) and
[SMS User Consent API](https://developers.google.com/identity/sms-retriever/user-consent/overview).
[SmartAuth](https://pub.dev/packages/smart_auth) is a Flutter wrapper for both — add it as a
dependency.

##### SMS Retriever API

Requires the app signature — see this
[guide](https://stackoverflow.com/questions/53849023/android-sms-retriever-api-computing-apps-hash-string-problem).

> **Note:** the app signature may differ between debug and release builds.

Include the app signature in the SMS your backend sends:

```text
Your ExampleApp code is: 123456
kg+TZ3A5qzS
```

The code is applied automatically, without user interaction.
[Example code](example/lib/demo/sms_retriever_api_example.dart)

##### SMS User Consent API

No app signature needed — the user is prompted to allow reading the message.
[Example code](example/lib/demo/user_consent_api_example.dart)

<img src="https://user-images.githubusercontent.com/26390946/158870589-a2d631fa-55d7-487f-8c30-d378bab4c21d.png" height="700" alt="Request Hint" />

## Tips

### Controller

```
// Create controller
final pinController = TextEditingController();

// Set text programmatically
pinController.setText('1222');

// Append typed character, useful with a custom keyboard.
// Second argument is the pin length.
pinController.append('1', 4);

// Delete last character
pinController.delete();

// Don't call setText, append or delete in build method — this is just an illustration.
return Pinput(
  controller: pinController,
);
```

### Focus

```
// Create focus node
final pinputFocusNode = FocusNode();

// Focus Pinput
pinputFocusNode.requestFocus();

// Unfocus Pinput
pinputFocusNode.unfocus();

// Don't call requestFocus or unfocus in build method — this is just an illustration.
return Pinput(
  focusNode: pinputFocusNode,
);
```

### Validation

```
// Create key
final formKey = GlobalKey<FormState>();

// Validate manually.
// Don't call validate in build method — this is just an illustration.
formKey.currentState!.validate();

return Form(
  key: formKey,
  child: Pinput(
    // --- Without validator ---
    // If true, error state is applied no matter what validator returns.
    forceErrorState: true,
    // Displayed under the Pinput.
    errorText: 'Error',

    // --- With validator ---
    // Validates after the user taps the keyboard done button or completes the Pinput.
    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
    validator: (pin) {
      if (pin == '2224') return null;
      // Displayed under the Pinput.
      return 'Pin is incorrect';
    },
  ),
);
```

### Digits only

`keyboardType: TextInputType.number` only changes the keyboard — pasted or autofilled text can still contain
other characters. A pasted `123-456` would become `123-45` and complete the Pinput with a wrong code.
Filter the input to keep digits only:

```
import 'package:flutter/services.dart';

return Pinput(
  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
);
```

## FAQ

#### Autofill isn't working on iOS?

- Make sure you are using a real device, not a simulator.
- Temporarily replace `Pinput` with `TextField` and check if autofill works. If not, the problem is
  probably the SMS you are receiving — autofill doesn't work with most languages.
- If you are on a non-stable Flutter channel, something might be broken inside the framework.

#### Using `firebase_auth`?

See [With `firebase_auth`](#with-firebase_auth).

## Support

PRs welcome! Check the [example app](https://github.com/SunnatilloShavkatov/flutter_pinput/tree/master/example/lib)
for more templates.

Don't forget to give it a star ⭐
