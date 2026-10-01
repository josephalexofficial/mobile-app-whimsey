# mobile-app-whimsey

Flutter app for the Whimsey Technologies agency site — services, projects, and contact on Android.

Repository: [josephalexofficial/mobile-app-whimsey](https://github.com/josephalexofficial/mobile-app-whimsey)

## 1. System Overview and Key Capabilities

- **Platform sections:** Home, About, Services, Projects, and Contact, with a fixed header and bottom tab bar.
- **Detail screens:** Nine service pages and six project case studies, including image preview and testimonials.
- **Contact delivery:** The scoping form validates input and sends it to `whimseytech@gmail.com` through EmailJS.
- **Theme:** Light and dark canvases, saved on the device.
- **Launcher icon:** The full Whimsey mark and tagline sit inside the home-screen shape with space around the artwork.

## 2. Architecture and Data Flow

Screens read local catalogs. The contact form is the only network call. Navigation and theme state live in one controller above the widget tree.

```text
[Tab screens / detail screens]
        -> [WhimseyAppController]
        -> [Local catalogs: services, projects, FAQ]
        -> [ContactEmailService]
        -> [EmailJS HTTPS API]
```

Dart file names use `snake_case` because that is the Flutter framework default.

Feature folders:

```text
lib/
├── common/          theme, navigation, errors, shared widgets
└── features/
    ├── shell/
    ├── home/
    ├── about/
    ├── services/
    ├── projects/
    └── contact/
```

## 3. Technology Stack

- **Runtime and language:** Flutter stable, Dart 3.8
- **Framework:** Flutter, Material 3
- **Persistence:** `shared_preferences` for the theme choice
- **Styling and UI:** Flutter widgets, bundled Jost, `flutter_svg` for the service artwork
- **External links:** `url_launcher` for phone, email, and social profiles
- **Infrastructure:** Android APK built with the local Android SDK. Package name `com.whimseytech.whimsey_technologies`.

`flutter_svg` is required because Flutter cannot draw the existing SVG artwork. `url_launcher` is required because Dart cannot open another app. `shared_preferences` is required because Flutter has no built-in key-value store.

## 4. Prerequisites

- Flutter stable, with Dart 3.8 or newer
- Android SDK and JDK 17
- An Android device with USB debugging, or an Android emulator

## 5. Local Development Setup

```bash
git clone https://github.com/josephalexofficial/mobile-app-whimsey.git
cd mobile-app-whimsey
flutter pub get
copy dart_defines.example.json dart_defines.json
```

On macOS or Linux, use `cp` instead of `copy`.

Put the EmailJS values used by the website into `dart_defines.json`. That file stays on your machine and is not part of this repository.

```bash
flutter run --dart-define-from-file=dart_defines.json
```

The Cursor launch configuration `Whimsey Technologies` passes that file automatically.

## 6. Environment Configuration

| Variable | Required | Default | Description |
| --- | --- | --- | --- |
| `EMAILJS_SERVICE_ID` | Yes | None | EmailJS service identifier. |
| `EMAILJS_TEMPLATE_ID` | Yes | None | EmailJS template identifier. |
| `EMAILJS_PUBLIC_KEY` | Yes | None | EmailJS public client key. |

These values are compile-time defines. Restart the app after changing `dart_defines.json`.

The EmailJS template expects `from_name`, `from_email`, `reply_to`, `message`, and `service_interest`.

## 7. Operational and Build Commands

| Command | Action |
| --- | --- |
| `flutter pub get` | Installs Dart packages. |
| `flutter run --dart-define-from-file=dart_defines.json` | Starts the app on a connected device or emulator. |
| `flutter analyze` | Runs the Dart analyzer in strict mode. |
| `flutter build apk --release --dart-define-from-file=dart_defines.json` | Builds the release APK. |

The release build writes `build/app/outputs/flutter-apk/app-release.apk`. Copy it to `WhimseyTech.apk` in the project folder for installation:

```bash
copy build\app\outputs\flutter-apk\app-release.apk WhimseyTech.apk
```

`WhimseyTech.apk` is an install file for your phone. It is not stored in this repository. If a previous build is already installed, uninstall it before installing the new APK so Android refreshes the launcher icon.

## 8. License

Proprietary. © 2026 Whimsey Technologies. All rights reserved.
