import 'package:burgergo/setting/about.dart';
import 'package:burgergo/setting/help.dart';
import 'package:burgergo/setting/savedaddress.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
         automaticallyImplyLeading: false, 
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: Icon(Icons.lock, color: Colors.black),
              title: Text('Saved Addresses'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => SavedAddress()));
              },
            ),
          ),
          Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: Icon(Icons.help, color: Colors.black),
              title: Text('Help & Support'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => Help()));
              },
            ),
          ),
          Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: Icon(Icons.info, color: Colors.black),
              title: Text('About'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => About()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
