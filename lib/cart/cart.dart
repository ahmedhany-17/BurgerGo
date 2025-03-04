import 'package:burgergo/cart/successfull.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  
Future<Map<String, dynamic>?> getSavedAddress() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Users')
      .doc(userId)
      .collection('Addresses')
      .limit(1)
      .get();

  if (snapshot.docs.isNotEmpty) {
    return snapshot.docs.first.data() as Map<String, dynamic>;
  }
  return null;
}
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("🛒 Cart",style: TextStyle(color: Colors.white),), backgroundColor: Colors.deepOrange),
      body: cartProvider.cartItems.isEmpty
          ? Center(child: Text("Your cart is empty!"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      var item = cartProvider.cartItems[index];

                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: Image.network(item["imageUrl"], width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(item["name"], style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text("\$${item["price"]} x ${item["quantity"]}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, color: Colors.red),
                                onPressed: () => cartProvider.decreaseQuantity(index),
                              ),
                              Text(item["quantity"].toString(), style: TextStyle(fontSize: 18)),
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.green),
                                onPressed: () => cartProvider.increaseQuantity(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                FutureBuilder(
  future: getSavedAddress(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    if (!snapshot.hasData) {
      return Text("No saved address found!");
    }

    var address = snapshot.data!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Deliver to: ${address['label'] ?? 'Unnamed Address'}",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text("${address['street']}, ${address['building']}"),
        Text("Floor: ${address['floor']}, Apt: ${address['aptNo']}"),
        Text("Phone: ${address['phone']}"),
      ],
    );
  },
),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text("Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, padding: EdgeInsets.all(12)),
                        onPressed: () {
                           Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SuccessfulPage()),
                  );
                          cartProvider.clearCart();
                        },
                        child: Text("Complete Purchase", style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}