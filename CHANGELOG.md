## 0.1.1

* Added optional `theme` fallback so `AutoThemeApp` can run without a user-provided source theme.
* Added `HardcodedColorStrategy.colorFilter` as an experimental fallback for apps that hardcode colors in widgets.
* Added `hardcodedColorFilterStrength` to control fallback color-filter intensity.
* Added tests covering omitted theme usage and hardcoded-color fallback behavior.

## 0.1.0

* Initial working release of `auto_theme`.
* Added automatic opposite-theme generation from a single theme.
* Added `AutoThemeApp`, `AutoThemeController`, and toggle widgets.
* Added an example app and tests.
