# Attendant App

**Attendant App** is a cross-platform (Android, iOS, Flutter Web) offline-first employee attendance application built with Flutter, Riverpod, Drift ORM (SQLite / SQLite WASM), and real-time on-device Face Detection.

---

## 1. Demo Credentials

The database automatically seeds a demo account upon first launch:

| Field | Value |
|---|---|
| **Employee ID** | `EMP001` (or `EMP-001`) |
| **Name** | Demo Employee |
| **Email** | `employee@attendant.local` |
| **Password** | `Attendant123!` (or `attendant123`) |
| **Department** | Engineering |
| **Position** | Senior Software Engineer |

> Only the cryptographic SHA-256 hash of the password is saved in SQLite.

---

## 2. Core Features

1. **Authentication**
   - Login with Employee ID or Email.
   - Secure SHA-256 password hash comparison.
   - Session persistence via `SharedPreferences`.
   - Automatic session restoration & route protection via `GoRouter`.
   - Logout clears active session.

2. **Dashboard**
   - Real-time live digital clock and date in Indonesian/local time.
   - Live attendance status badge (`Not Checked In`, `Working`, `Late`, `Completed`).
   - Today's Check-in time, Check-out time, and working duration (with lunch break automatically deducted).
   - Today's shift schedule summary.
   - Contextual Action button to launch camera scanner.

3. **Attendance & Face Detection Engine**
   - Real-time on-device Face Detection:
     - **Mobile (Android & iOS)**: Camera feed + Google ML Kit Face Detection.
     - **Web**: Browser Camera stream + live framing detection.
   - Detection Rules:
     - Exactly **1 face** required.
     - Face must be **centered** inside the scanner guidance oval.
     - Face size must fit proportional bounding limits.
     - Confirmation button is disabled/locked if no face or multiple faces are in frame.
   - Atomic database transactions with duplicate check-in / check-out prevention.

4. **Attendance History**
   - List of all completed and working attendance records for the logged-in employee.
   - Filter by specific date or month.
   - Detail modal showing check-in/out timestamps, face detection status, and effective working hours.

5. **Work Schedule**
   - Weekly work shift schedule (Monday through Friday, 08:00 - 17:00, 12:00 - 13:00 break).
   - Upcoming national/company holidays loaded directly from SQLite.

6. **Employee Profile**
   - View profile details (ID, Name, Email, Department, Position).
   - Edit profile information directly in SQLite.
   - Change demo password locally with current password verification.
   - Logout button.

---

## 3. Technology Stack & Architecture

- **Framework**: Flutter 3.44.8 / Dart 3.12.2
- **Architecture**: Feature-First with Repository Pattern
- **State Management**: Riverpod (`Notifier` & `StreamProvider`)
- **Routing**: GoRouter with route guards
- **Database**: Drift ORM with SQLite
  - **Mobile**: Native SQLite via `drift_flutter`
  - **Web**: SQLite WebAssembly (`sqlite3.wasm` & `drift_worker.js`)
- **Face Detection**: Local on-device detection without remote servers

---

## 4. Setup & Running Instructions

### Prerequisites
- Flutter SDK (v3.24+ recommended)
- Android Studio / Xcode (for mobile builds)
- Chrome / Safari / Edge (for Web)

### Getting Started
```bash
# 1. Fetch dependencies
flutter pub get

# 2. Run code generation (if modifying tables)
dart run build_runner build --delete-conflicting-outputs

# 3. Run all automated tests
flutter test

# 4. Run static analysis
flutter analyze
```

### Running on Flutter Web
```bash
flutter run -d chrome
```

### Building for Web
```bash
flutter build web --no-tree-shake-icons
```
The output files in `build/web/` will include `sqlite3.wasm` and `drift_worker.js` for full local SQLite persistence.

### Building for Android
```bash
flutter build apk --debug
```

### Building for iOS
```bash
flutter build ios --no-codesign
```

---

## 5. Known Limitations & Architecture Constraints (MVP)

- **Local-First / No Cloud Sync**: In accordance with the MVP specification, data is saved locally in SQLite on the active device. Data does not synchronize across different physical devices or different browser profiles.
- **Face Detection vs Face Recognition**: The application enforces **Face Detection** (verifying that a live human face is positioned in front of the camera), not facial biometric recognition (matching identity against a photo database).
- **Web Camera Permissions**: Running on Web requires serving through `http://localhost` or `https://` for browsers to grant camera access.
