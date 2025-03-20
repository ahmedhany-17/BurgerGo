import 'package:burgergo/presentation/screens/cart/cart.dart';
import 'package:burgergo/presentation/providers/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChickenBurgers extends StatefulWidget {
  @override
  State<ChickenBurgers> createState() => _ChickenBurgersState();
}

class _ChickenBurgersState extends State<ChickenBurgers> {
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
              'Chicken Burgers',
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
                FirebaseFirestore.instance.collection('chickenburgers').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              var chickenburgers = snapshot.data!.docs;

              return GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: chickenburgers.length,
                itemBuilder: (context, index) {
                  var burger = chickenburgers[index].data();
                  return ProductCard(
                    name: burger['name'] ?? 'Unknown',
                    price: burger['price']?.toDouble() ?? 0.0,
                    imageUrl: burger['image'] ?? '',
                    deliveryTime: burger['deliveryTime'] ?? 'N/A',
                    rating: burger['rating']?.toDouble() ?? 0.0,
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

class ProductCard extends StatelessWidget {
  ProductCard({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.deliveryTime,
    required this.rating,
  });

  final String name;
  final double price;
  final String imageUrl;
  final String deliveryTime;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<CartProvider>(context, listen: false).addToCart({
          'name': name,
          'price': price,
          'imageUrl': imageUrl,
          'deliveryTime': deliveryTime,
          'rating': rating,
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$name added to cart!')));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "\$${price.toStringAsFixed(2)}",
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Delivery time: $deliveryTime",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 5),
                      Text(
                        rating.toString(),
                        style: TextStyle(color: Colors.amber),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}