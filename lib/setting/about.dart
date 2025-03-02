import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About BurgerGo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'BurgerGo is a leading fast-food chain that specializes in delicious burgers and quick service. Our mission is to provide high-quality food and exceptional customer service to our valued customers.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Our Story',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Founded in 2025, BurgerGo has quickly grown to become a favorite among burger enthusiasts. With a commitment to using fresh ingredients and innovative recipes, we have established a loyal customer base.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}