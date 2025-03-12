import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static Future<void> saveUserName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("USERNAMEKEY", name);
  }

  static Future<void> saveUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("USEREMAILKEY", email);
  }

  // static Future<void> saveUserProfile(String profileUrl) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString("USERPROFILEKEY", profileUrl);
  // }

  static Future<void> saveUserId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("USERIDKEY", id);
  }

  static Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("USERNAMEKEY");
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("USEREMAILKEY");
  }

  // static Future<String?> getUserProfile() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("USERPROFILEKEY");
  // }

  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("USERIDKEY");
  }

  Future<void> fetchAndSaveUserData() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("Users").doc(user.uid).get();
    if (userDoc.exists) {
      String name = userDoc.get("name") ?? "No Name";
      String email = userDoc.get("email") ?? "No Email";
     // String profile = userDoc.get("profile") ?? "";

      await saveUserName(name);
      await saveUserEmail(email);
      // await saveUserProfile(profile);

      print("User data saved locally: Name=$name, Email=$email");
    }
  }
}
}