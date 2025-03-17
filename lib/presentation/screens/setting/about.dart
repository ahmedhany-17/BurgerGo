import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Center(
              child: Icon(
                Icons.fastfood,
                size: 80,
                color: Colors.red.shade400,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "BurgerGo",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                ),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                "Version 1.0.0",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "About the App",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "BurgerGo is your go-to app for ordering delicious burgers and meals with ease. Whether you're craving beef, chicken, or snacks, we've got it all. Order, track, and enjoy – all in a few taps!",
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Our Story",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "BurgerGo started as a small idea during a late-night coding session by a passionate developer who loves food and tech. With a dream of simplifying food delivery in Egypt, BurgerGo was born – designed to be fast, simple, and satisfying.",
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: Text(
                "Made with love by Ahmed Hany",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}