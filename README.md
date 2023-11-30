# Mobile_Backend_M10

## Getting Started

To set up permissions in your Android app, follow these steps:

1. Open the `android/app/src/main/AndroidManifest.xml` file.
2. Add the following permissions inside the `<manifest>` tag:

```xml
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_CONTACTS" />
<uses-permission android:name="android.permission.CAMERA" />
