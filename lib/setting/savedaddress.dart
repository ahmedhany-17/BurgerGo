import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SavedAddress extends StatefulWidget {
  @override
  _SavedAddressState createState() => _SavedAddressState();
}

class _SavedAddressState extends State<SavedAddress> {
  String addressType = 'Apartment';
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _aptNoController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _directionsController = TextEditingController();
  final TextEditingController _labelController = TextEditingController();

  List<Map<String, String>> addresses = [];

void _addAddress() async {
  String userId = FirebaseAuth.instance.currentUser!.uid; // احصل على الـ User ID

  Map<String, String> newAddress = {
    'addressType': addressType,
    'building': _buildingController.text,
    'aptNo': _aptNoController.text,
    'floor': _floorController.text,
    'street': _streetController.text,
    'directions': _directionsController.text,
    'phone': _phoneController.text,
    'label': _labelController.text,
  };

  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userId)
      .collection('Addresses')
      .add(newAddress);

  setState(() {
    addresses.add(newAddress);
    _buildingController.clear();
    _aptNoController.clear();
    _floorController.clear();
    _streetController.clear();
    _directionsController.clear();
    _phoneController.clear();
    _labelController.clear();
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ChoiceChip(
                  label: Text('Apartment'),
                  selected: addressType == 'Apartment',
                  onSelected: (selected) {
                    setState(() {
                      addressType = 'Apartment';
                    });
                  },
                ),
                ChoiceChip(
                  label: Text('House'),
                  selected: addressType == 'House',
                  onSelected: (selected) {
                    setState(() {
                      addressType = 'House';
                    });
                  },
                ),
                ChoiceChip(
                  label: Text('Office'),
                  selected: addressType == 'Office',
                  onSelected: (selected) {
                    setState(() {
                      addressType = 'Office';
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _buildingController,
              decoration: InputDecoration(
                labelText: 'Building name',
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _aptNoController,
                    decoration: InputDecoration(
                      labelText: 'Apt. no.',
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _floorController,
                    decoration: InputDecoration(
                      labelText: 'Floor',
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              controller: _streetController,
              decoration: InputDecoration(
                labelText: 'Street',
              ),
            ),
            TextField(
              controller: _directionsController,
              decoration: InputDecoration(
                labelText: 'Additional directions',
              ),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone number',
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                    child: Image.asset('assets/images/egypt_flag.png', width: 24),
                ),
              ),
            ),
            TextField(
              controller: _labelController,
              decoration: InputDecoration(
                labelText: 'Address label',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _addAddress,
              label: Text('Save Address'),
              style: ElevatedButton.styleFrom(
              backgroundColor:  Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: TextStyle(fontSize: 16),
              foregroundColor: Colors.white,
              iconColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('${addresses[index]['addressType']} - ${addresses[index]['building']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Apt. no.: ${addresses[index]['aptNo']}'),
                          Text('Floor: ${addresses[index]['floor']}'),
                          Text('Street: ${addresses[index]['street']}'),
                          Text('Directions: ${addresses[index]['directions']}'),
                          Text('Phone: ${addresses[index]['phone']}'),
                          Text('Label: ${addresses[index]['label']}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            addresses.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}