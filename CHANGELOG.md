## 2.0.1

* Fix: `Pinput.builder` now defaults `autofillHints` to `[AutofillHints.oneTimeCode]`, matching `Pinput()`,
  so iOS SMS code autofill works out of the box with the builder constructor too.
* Fix: Characters made of several UTF-16 code units (emoji, combined characters) now fill exactly one pin
  instead of being split across pins. `PinputControllerExt.length`, `delete()` and `append()` count characters too.
* Fix: Replacing `smsRetriever` now disposes the old retriever and listens to the new one; a late code from
  the replaced retriever is ignored.
* Fix: The animated cursor no longer keeps scheduling frames, so `WidgetTester.pumpAndSettle` settles while
  `Pinput` is focused. The cursor now blinks like the native caret instead of pulsing continuously.
* Fix: Decreasing `length` now trims a longer pin to the new length instead of keeping the extra characters.
* Fix: `debugFillProperties` no longer lists `enabled`, `obscureText` and `keyboardType` twice, and reports the
  real defaults of `useNativeKeyboard`, `textInputAction`, `separatorBuilder` and `autofillHints`.
* Docs: README explains how to accept digits only with `FilteringTextInputFormatter.digitsOnly`.
* Docs: Updated the `SmsRetriever` documentation and SmartAuth example to `smart_auth` 3.x.
* Chore: Removed the legacy `_ambiguate` helper and a no-op platform `switch`.
* Chore: Added GitHub Actions CI (format, analyze, test, publish dry-run on Flutter 3.47.0 and stable)
  and tests for validation, input, keyboard, clipboard, SMS retriever and widget lifecycle.
* Chore: Rewrote the 1.0.0 and 1.0.1 changelog entries from the git history.

## 2.0.0

* **Breaking:** Migrated from `package:flutter/material.dart` and `package:flutter/cupertino.dart` to the decoupled
  [`material_ui`](https://pub.dev/packages/material_ui) and [`cupertino_ui`](https://pub.dev/packages/cupertino_ui) packages.
  `Pinput` must now be used under a `MaterialApp` / `Theme` from `material_ui`; see the migration guide in the README.
* **Breaking:** Minimum SDK raised to Dart `3.13` / Flutter `3.47`. Stay on `1.0.3` for older Flutter versions.
* Breaking: Removed `hintLocales` parameter (as in upstream pinput 6.0.1).
* Sync with upstream pinput 6.0.2.
* Perf: Dropped `IntrinsicWidth` (extra layout pass); layout is unchanged, verified across parent constraints.
* Fix: Resolved pub.dev static analysis warnings (`document_ignores`, `unnecessary_unawaited`).
* Chore: Published package now ships only `example/lib/main.dart` (archive 26 KB -> 21 KB).
* Chore: Constructors use the new `new` syntax.

## 1.0.3

* Refactor: Code cleanup and optimization in pinput.dart and pinput_state.dart.
* Update: Improve code structure and maintainability.
* Update: Example app improvements and updates.

## 1.0.2

* Fix: Correct issue tracker URL in pubspec.yaml (changed from `.gitissues` to `/issues`).
* Update: Update README.md with correct pub package link (changed from `pinput` to `flutter_pinput`).
* Update: Update GitHub repository links in README.md (changed from `tkko/flutter_pinput` to `SunnatilloShavkatov/flutter_pinput`).
* Update: Update LinkedIn profile link in README.md.

## 1.0.1

* Chore: Point `homepage`, `repository` and `issue_tracker` to this repository.
* Chore: Removed files that only applied to the upstream repository (funding, issue templates, migration guide,
  publish script).

## 1.0.0

* Initial release of `flutter_pinput`, forked from [`pinput`](https://pub.dev/packages/pinput) 5.0.3.
* Breaking: Removed `SmsRetriever.listenForMultipleSms`.
