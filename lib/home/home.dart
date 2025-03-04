import 'package:burgergo/home/menu.dart';
import 'package:burgergo/home/menu/appetizers.dart';
import 'package:burgergo/home/menu/beef.dart';
import 'package:burgergo/home/menu/chicken.dart';
import 'package:burgergo/home/menu/drinks.dart';
import 'package:burgergo/home/menu/fries.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(1),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Welcome to BurgerGo!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Delicious Food',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  shadows: [Shadow(color: Colors.black, offset: Offset(1, 1))],
                ),
              ),
              Text(
                'Discover and Get Great Burger',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              SizedBox(height: 20),
              MenuItem(
                title: 'Beef Burgers',
                color: Colors.brown,
                imageUrl:
                    'https://th.bing.com/th/id/OIP.KCq2TaqShT31yTWgdHgv1AHaHa?w=170&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BeefBurgers()),
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
                    MaterialPageRoute(builder: (context) => ChickenBurgers()),
                  );
                },
              ),
              MenuItem(
                title: 'French Fries',
                color: Colors.yellow,
                imageUrl:
                    'https://th.bing.com/th/id/OIP.te6G4PkwzzyVZiMbGcZQLQHaEu?w=277&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                onTap: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => Fries()));
                },
              ),
              MenuItem(
                title: 'Appetizers',
                color: Colors.redAccent,
                imageUrl:
                    'https://th.bing.com/th/id/OIP.YiflQQehGIso6vLS2DU-rAHaE8?w=264&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                onTap: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => Appetizers()));
                },
              ),
               MenuItem(
                title: 'Cold Drinks',
                color: Colors.blue,
                imageUrl:
                    'https://th.bing.com/th/id/R.2bac6836fef41ad56e08d436a58b5533?rik=HlNOF7PMuPTG4g&pid=ImgRaw&r=0',
                onTap: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => Drinks()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

