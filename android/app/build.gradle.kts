plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin") // يجب أن يكون بعد Android و Kotlin
    id("com.google.gms.google-services") // Firebase
}

android {
    namespace = "com.example.burgergo"
    compileSdk = 34
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.example.burgergo"
        minSdk = 23
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "11"
    }

   buildTypes {
    debug {
        signingConfig = signingConfigs.getByName("debug")
    }
    release {
        signingConfig = signingConfigs.getByName("debug") // استخدم debug لو معملتش release signing
    }
  }
}

flutter {
    source = "../.."
}