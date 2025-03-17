import 'package:burgergo/presentation/screens/home/welcomeheader.dart';
import 'package:burgergo/presentation/widgets/menuitem/menu.dart';
import 'package:burgergo/presentation/screens/menu/appetizers.dart';
import 'package:burgergo/presentation/screens/menu/beef.dart';
import 'package:burgergo/presentation/screens/menu/chicken.dart';
import 'package:burgergo/presentation/screens/menu/drinks.dart';
import 'package:burgergo/presentation/screens/menu/fries.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: SafeArea(
        child:
            currentUser == null
                ? Center(child: Text("User not logged in"))
                : StreamBuilder<DocumentSnapshot>(
                  stream:
                      FirebaseFirestore.instance
                          .collection('Users')
                          .doc(currentUser!.uid)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return Center(child: Text("User data not found"));
                    }

                    final userData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    final userName = userData['Name'] ?? 'Guest';

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FancyWelcomeHeader(userName: userName),

                          const SizedBox(height: 20),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Stack(
                                children: [
                                  Image.network(
                                    'https://images.unsplash.com/photo-1550547660-d9450f859349',
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    left: 20,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Delicious Food',
                                          style: TextStyle(
                                            fontSize: 26,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Discover and Get Great Burger',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),

                          // Grid of menu items
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.9,
                              children: [
                                MenuItem(
                                  title: 'Beef Burgers',
                                  color: Colors.brown,
                                  imageUrl:
                                      'https://th.bing.com/th/id/OIP.KCq2TaqShT31yTWgdHgv1AHaHa?w=170&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => BeefBurgers(),
                                      ),
                                    );
                                  },
                                ),
                                MenuItem(
                                  title: 'Chicken Burgers',
                                  color: Colors.orange,
                                  imageUrl:
                                      'https://img.freepik.com/premium-photo/burger-with-chicken-yellow-background-bright-background_560930-982.jpg?w=2000',
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ChickenBurgers(),
                                      ),
                                    );
                                  },
                                ),
                                MenuItem(
                                  title: 'French Fries',
                                  color: Colors.yellow[700]!,
                                  imageUrl:
                                      'https://th.bing.com/th/id/OIP.te6G4PkwzzyVZiMbGcZQLQHaEu?w=277&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Fries(),
                                      ),
                                    );
                                  },
                                ),
                                MenuItem(
                                  title: 'Appetizers',
                                  color: Colors.redAccent,
                                  imageUrl:
                                      'https://th.bing.com/th/id/OIP.YiflQQehGIso6vLS2DU-rAHaE8?w=264&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Appetizers(),
                                      ),
                                    );
                                  },
                                ),
                                MenuItem(
                                  title: 'Cold Drinks',
                                  color: Colors.blue,
                                  imageUrl:
                                      'https://th.bing.com/th/id/R.2bac6836fef41ad56e08d436a58b5533?rik=HlNOF7PMuPTG4g&pid=ImgRaw&r=0',
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Drinks(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
