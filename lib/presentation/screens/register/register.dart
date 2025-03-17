import 'package:burgergo/presentation/screens/auth/auth.dart';
import 'package:burgergo/presentation/screens/login/login.dart';
import 'package:burgergo/presentation/widgets/bottomnav/bottomnav.dart';
import 'package:burgergo/services/databasemethods.dart';
import 'package:burgergo/services/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _isLoading = false;

 Future<void> userRegister() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() => _isLoading = true);

  try {
    debugPrint("Starting registration...");

    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    String userId = userCredential.user!.uid;

    debugPrint("User created successfully with ID: $userId");

    Map<String, dynamic> userInfo = {
      "Name": nameController.text.trim(),
      "Email": emailController.text.trim(),
      "Id": userId,
    };

    await DatabaseMethods().addUserDetail(userInfo, userId);

    debugPrint("User data saved in Firestore");

    await SharedPreferenceHelper.saveUserName(nameController.text.trim());
    await SharedPreferenceHelper.saveUserEmail(emailController.text.trim());
    await SharedPreferenceHelper.saveUserId(userId);

    debugPrint("User data saved in SharedPreferences");

    debugPrint("Navigating to Home...");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNav(initialIndex: 0,)),
    );
  } on FirebaseAuthException catch (e) {
    String message = "An error occurred, please check your credentials.";
    if (e.code == 'weak-password') {
      message = "password is too weak.";
    } else if (e.code == 'email-already-in-use') {
      message = "The account already exists for that email.";
    } else if (e.message != null) {
      message = e.message!;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontSize: 18.0, color: Colors.black)),
        backgroundColor: Colors.red[300],
      ),
    );

    debugPrint("FirebaseAuthException: $message");
  } catch (e) {
    debugPrint("Unexpected error: $e");
  }

  setState(() => _isLoading = false);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFff5c30), Color(0xFFe74b1a)],
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).size.height / 3,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
            child: Column(
              children: [
                Text(
                  "BurgerGo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontFamily: 'Poppins1',
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 50.0),

                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.0),

                          TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Name',
                              prefixIcon: Icon(Icons.person_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),

                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),

                          TextFormField(
                            controller: passwordController,
                            obscureText: !_isPasswordVisible,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.0),

                          ElevatedButton(
                            onPressed: _isLoading ? null : userRegister,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0Xffff5722),
                              padding: EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: _isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    "SIGN UP",
                                    style: TextStyle(fontSize: 18, color: Colors.white),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.0),

                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView()));
                  },
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                ),

                Spacer(),

                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Auth()));
                  },
                  child: Text('Back', style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

