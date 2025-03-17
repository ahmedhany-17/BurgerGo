import 'package:burgergo/services/notificationservice.dart';
import 'package:flutter/material.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  bool notificationsEnabled = true;

  void toggleNotifications(bool value) {
    setState(() {
      notificationsEnabled = value;
    });

    if (notificationsEnabled) {
      NotificationService.showNotification(
        id: 1,
        title: "Notifications Enabled",
        body: "You will now receive notifications.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications Settings"),
        backgroundColor: const Color(0xFFFF5722),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.notifications_active, color: Colors.orange),
              title: Text("Enable Notifications",
                  style: TextStyle(fontSize: 18.0)),
              trailing: Switch(
                value: notificationsEnabled,
                onChanged: toggleNotifications,
                activeColor: Colors.orange,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                NotificationService.showNotification(
                  id: 2,
                  title: "Test Notification",
                  body: "This is a test notification.",
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5722),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "Send Test Notification",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}