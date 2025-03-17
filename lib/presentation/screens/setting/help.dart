import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help & Support"),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Icon(
              Icons.support_agent,
              size: 80,
              color: Colors.red.shade400,
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "How can we help you?",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 25),
            Text(
              "Frequently Asked Questions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Divider(height: 20, thickness: 1),
            SizedBox(height: 10),

            _buildFAQItem(
              question: "How to place an order?",
              answer:
                  "Go to the menu, select your items, add them to the cart, and proceed to checkout.",
            ),
            _buildFAQItem(
              question: "Can I change my delivery address?",
              answer:
                  "Yes, go to Settings > Saved Addresses and update your address anytime.",
            ),
            _buildFAQItem(
              question: "Is there a delivery fee?",
              answer:
                  "Delivery fees vary depending on your location and will be shown at checkout.",
            ),

            SizedBox(height: 30),
            Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Divider(height: 20, thickness: 1),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.email, color: Colors.red),
              title: Text("support@burgergo.app"),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.red),
              title: Text("+20 100 123 4567"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            answer,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}