# ZuiTweak-magisk

[Korean Version](README.md)

## Overview
**ZuiTweak-magisk** is a Magisk/APatch module that applies various tweaks to Lenovo's Zui-based ROMs.

## Key Features
### Xiaoxin Pad Pro 12.7 (TB-371FC)
1. **Apply Korean Locale:** Applies the Korean locale system-wide.
   - Modifies the `test_mode` settings in `framework.jar` and `services.jar` and hooks only the modified values to implement multilingual support.
2. **Apply Previous Version's Korean Translations:** Applies the Korean translations from previous versions.
   - Implemented using RRO (Resource Runtime Overlay) for multilingual processing.
3. **Enable Play Store:** Activates Google Play Store.
4. **Remove Unnecessary/Chinese Apps:** Removes pre-installed unnecessary apps and Chinese apps.
5. **Enable Pen (Stylus) Service:** Enables the pen service functionality for using AP500U without pen pairing.

### Lenovo Y700 2023 (TB-320FC)
1. **Enable Multiple Space:** Activates the clone space (Multiple Space) feature.
   - Requires installation and activation of the [ZuiTweak](https://github.com/forumi0721/ZuiTweak) Xposed module.
2. **Remove Unnecessary Apps:** Removes pre-installed unnecessary apps.

### Common
1. **Framework Patch:** Integrates Framework Patcher GO. (A Magisk/KernelSU/APatch module that modifies `framework.jar` directly on the phone to build a valid system-level certificate chain.)
   - [Framework Patcher GO](https://github.com/changhuapeng/FrameworkPatcherGO)
2. **Force Widevine L3 for DRM Content Playback:** Forces Widevine L3 to enable DRM content playback.
   - [liboemcrypto.so disabler](https://github.com/Magisk-Modules-Repo/liboemcryptodisabler)
3. **Replace Bootanimation:** Replaces the boot animation.

## Source Code
The source code is available on GitHub: [ZuiTweak-magisk Source Code](https://github.com/forumi0721/ZuiTweak-magisk)

## License
This project is licensed under the GPLv2 License. For more details, please refer to the [LICENSE](https://github.com/forumi0721/ZuiTweak-magisk/blob/main/LICENSE).

## Installation Instructions
1. **Install Magisk/APatch**
   - ZuiTweak-magisk requires a rooted device to be used. (APatch is recommended)
2. **Download and Install ZuiTweak-magisk**
   - Download the latest version from the [Release Page](https://github.com/forumi0721/ZuiTweak-magisk/releases) and install it.
3. **Install and Activate ZuiTweak (Xposed Module)**
   - After installing Xposed, activate the ZuiTweak module.

## Important Notes
- This is not a fully guaranteed feature and may contain errors.

## Contact
If you encounter any issues or have questions while using the app, please report them via the [Issues Page](https://github.com/forumi0721/ZuiTweak-magisk/issues).

