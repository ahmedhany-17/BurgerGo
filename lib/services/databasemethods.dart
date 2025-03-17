import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addUserDetail(userInfo, userId) async {
    await FirebaseFirestore.instance.collection("Users").doc(userId).set(userInfo);
  }
}