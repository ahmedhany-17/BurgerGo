import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How can we help you?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'If you have any questions or need assistance, please feel free to reach out to us.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.red),
              title: Text('Call Us'),
              subtitle: Text('+1 234 567 890'),
              onTap: () {
                // Handle call action
              },
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.red),
              title: Text('Email Us'),
              subtitle: Text('support@burgergo.com'),
              onTap: () {
                // Handle email action
              },
            ),
          ],
        ),
      ),
    );
  }
}
