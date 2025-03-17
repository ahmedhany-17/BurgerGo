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

  List<Map<String, dynamic>> addresses = [];

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
    });
  }

  Future<void> deleteAddress(String docId, int index) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Addresses')
        .doc(docId)
        .delete();

    setState(() {
      addresses.removeAt(index);
    });
  }

  void _addAddress() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    Map<String, String> newAddress = {
      'addressType': addressType,
      'building': _buildingController.text.trim(),
      'aptNo': _aptNoController.text.trim(),
      'floor': _floorController.text.trim(),
      'street': _streetController.text.trim(),
      'directions': _directionsController.text.trim(),
      'phone': _phoneController.text.trim(),
      'label': _labelController.text.trim(),
    };

    DocumentReference docRef = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Addresses')
        .add(newAddress);

    newAddress['id'] = docRef.id;

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
      appBar: AppBar(title: Text('New Address')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['Apartment', 'House', 'Office'].map((type) {
                return ChoiceChip(
                  label: Text(type),
                  selected: addressType == type,
                  onSelected: (selected) {
                    setState(() {
                      addressType = type;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _buildingController,
              decoration: InputDecoration(labelText: 'Building name'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _aptNoController,
                    decoration: InputDecoration(labelText: 'Apt. no.'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _floorController,
                    decoration: InputDecoration(labelText: 'Floor'),
                  ),
                ),
              ],
            ),
            TextField(
              controller: _streetController,
              decoration: InputDecoration(labelText: 'Street'),
            ),
            TextField(
              controller: _directionsController,
              decoration: InputDecoration(labelText: 'Additional directions'),
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
              decoration: InputDecoration(labelText: 'Address label'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addAddress,
              child: Text('Save Address'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 16),
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: addresses.isEmpty
                  ? Center(child: Text('No saved addresses.'))
                  : ListView.builder(
                      itemCount: addresses.length,
                      itemBuilder: (context, index) {
                        final address = addresses[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                                '${address['addressType'] ?? ''} - ${address['building'] ?? ''}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Apt. no.: ${address['aptNo'] ?? ''}'),
                                Text('Floor: ${address['floor'] ?? ''}'),
                                Text('Street: ${address['street'] ?? ''}'),
                                Text(
                                    'Directions: ${address['directions'] ?? ''}'),
                                Text('Phone: ${address['phone'] ?? ''}'),
                                Text('Label: ${address['label'] ?? ''}'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                deleteAddress(address['id'], index);
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