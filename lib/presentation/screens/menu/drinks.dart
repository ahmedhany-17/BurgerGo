import 'package:burgergo/presentation/screens/cart/cart.dart';
import 'package:burgergo/presentation/providers/cart_provider.dart';
import 'package:burgergo/presentation/widgets/productcard/productcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Drinks extends StatefulWidget {
  @override
  State<Drinks> createState() => _DrinksState();
}

class _DrinksState extends State<Drinks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        title: Container(
          width: 180,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 7),
          decoration: BoxDecoration(
            color: Color(0xffef2a39),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Center(
            child: Text(
              'Drinks',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        centerTitle: true,
         actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.red),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => CartPage()));
            },
          ),
         ],
      ),
       body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('drinks').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              var drinks = snapshot.data!.docs;

              return GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: drinks.length,
                itemBuilder: (context, index) {
                  var drink = drinks[index].data();
                  return DrinksProductCard(
                    name: drink['name'] ?? 'Unknown',
                    price: drink['price']?.toDouble() ?? 0.0,
                    imageUrl: drink['image'] ?? '',
                    deliveryTime: drink['deliveryTime'] ?? 'N/A',
                    rating: drink['rating']?.toDouble() ?? 0.0,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}


