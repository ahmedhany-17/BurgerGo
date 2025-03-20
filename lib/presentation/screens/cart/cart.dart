import 'package:burgergo/presentation/screens/cart/successfull.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> addresses = [];
  Map<String, dynamic>? selectedAddress;

  @override
  void initState() {
    super.initState();
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Addresses')
        .get();

    setState(() {
      addresses = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();

      if (addresses.isNotEmpty) {
        selectedAddress = addresses[0];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("🛒 Cart", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: Image.network(item["imageUrl"],
                              width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(item["name"],
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              "\$${item["price"]} x ${item["quantity"]}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, color: Colors.red),
                                onPressed: () =>
                                    cartProvider.decreaseQuantity(index),
                              ),
                              Text(item["quantity"].toString(),
                                  style: TextStyle(fontSize: 18)),
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.green),
                                onPressed: () =>
                                    cartProvider.increaseQuantity(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Dropdown لاختيار العنوان
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade200,
                      border: Border.all(color: Colors.grey),
                    ),
                    child: DropdownButton<Map<String, dynamic>>(
                      isExpanded: true,
                      hint: Text("Select Delivery Address"),
                      value: selectedAddress,
                      icon: Icon(Icons.keyboard_arrow_down),
                      underline: SizedBox(),
                      onChanged: (value) {
                        setState(() {
                          selectedAddress = value;
                        });
                      },
                      items: addresses.map((address) {
                        String label = address['label'] ?? 'No Label';
                        String street = address['street'] ?? '';
                        String building = address['building'] ?? '';

                        return DropdownMenuItem(
                          value: address,
                          child: Text('$label - $street $building'),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // تفاصيل العنوان المختار
                if (selectedAddress != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Deliver to: ${selectedAddress!['label'] ?? 'Unnamed Address'}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                            "${selectedAddress!['street'] ?? ''}, ${selectedAddress!['building'] ?? ''}"),
                        Text(
                            "Floor: ${selectedAddress!['floor'] ?? '-'}, Apt: ${selectedAddress!['aptNo'] ?? '-'}"),
                        Text("Phone: ${selectedAddress!['phone'] ?? '-'}"),
                      ],
                    ),
                  ),

                // السعر و زر الشراء
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        "Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          padding: EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SuccessfulPage()));
                          cartProvider.clearCart();
                        },
                        child: Text("Complete Purchase",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}