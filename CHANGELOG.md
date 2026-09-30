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

* Fix: Correct typo in documentation.
* Update: Improve performance of data processing module.

## 1.0.0

* TODO: Describe initial release.
