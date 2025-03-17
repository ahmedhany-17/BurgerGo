import 'package:burgergo/presentation/screens/cart/cart.dart';
import 'package:burgergo/presentation/providers/cart_provider.dart';
import 'package:burgergo/presentation/widgets/productcard/productcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Appetizers extends StatefulWidget {
  @override
  State<Appetizers> createState() => _AppetizersState();
}

class _AppetizersState extends State<Appetizers> {
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
              'Appetizers',
              style: TextStyle(
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
                FirebaseFirestore.instance.collection('appetizers').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              var appetizers = snapshot.data!.docs;

              return GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: appetizers.length,
                itemBuilder: (context, index) {
                  var appetizer = appetizers[index].data();
                  return AppetizersProductCard(
                    name: appetizer['name'] ?? 'Unknown',
                    price: appetizer['price']?.toDouble() ?? 0.0,
                    imageUrl: appetizer['image'] ?? '',
                    deliveryTime: appetizer['deliveryTime'] ?? 'N/A',
                    rating: appetizer['rating']?.toDouble() ?? 0.0,
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

