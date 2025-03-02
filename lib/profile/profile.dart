import 'dart:io';
import 'package:burgergo/auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? profileUrl, name, email;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection("Users").doc(user.uid).get();

        setState(() {
          name = userDoc["Name"] ?? "No Name";
          email = userDoc["Email"] ?? "No Email";
          profileUrl = userDoc["Profile"] ?? "";
        });
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
    setState(() => _isLoading = false);
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => selectedImage = File(image.path));
      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    if (selectedImage == null) return;

    try {
      String fileName = "${FirebaseAuth.instance.currentUser!.uid}.jpg";
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("profileImages/$fileName");

      UploadTask uploadTask = firebaseStorageRef.putFile(selectedImage!);
      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"Profile": downloadUrl});

      setState(() {
        profileUrl = downloadUrl;
      });

      print("Profile updated successfully.");
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 45.0),
                      height: MediaQuery.of(context).size.height / 4.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width,
                            105.0,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 6.5,
                        ),
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: profileUrl != null && profileUrl!.isNotEmpty
                                ? NetworkImage(profileUrl!)
                                : AssetImage("assets/images/logo.png") as ImageProvider,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 70.0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          name ?? 'Loading...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                _buildInfoTile(Icons.person, "Name", name ?? "Loading..."),
                SizedBox(height: 20.0),
                _buildInfoTile(Icons.email, "Email", email ?? "Loading..."),
                SizedBox(height: 20.0),
                _buildActionTile(Icons.refresh, "Reload Data", _loadUserData),
                SizedBox(height: 20.0),
                _buildActionTile(Icons.delete, "Delete Account", _deleteAccount),
                SizedBox(height: 20.0),
                _buildActionTile(Icons.logout, "Logout", _logout),
              ],
            ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black),
              SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 2.0,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.black),
                SizedBox(width: 20.0),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _deleteAccount() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection("Users").doc(user.uid).delete();
        await user.delete();
        print("User deleted successfully.");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Auth()));
      }
    } catch (e) {
      print("Error deleting user: $e");
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Auth()));
  }
}