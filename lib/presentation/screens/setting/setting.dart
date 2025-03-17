import 'package:burgergo/presentation/screens/setting/change_email.dart';
import 'package:burgergo/presentation/screens/setting/changepass.dart';
import 'package:burgergo/presentation/screens/saved_address/savedaddress.dart';
import 'package:burgergo/presentation/screens/setting/about.dart';
import 'package:burgergo/presentation/screens/setting/help.dart';
import 'package:burgergo/presentation/screens/setting/notification.dart';
import 'package:burgergo/presentation/widgets/settingitem/settingitem.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  void navigateTo(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          SettingItem(
            icon: Icons.location_on_outlined,
            title: 'Saved Addresses',
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SavedAddress()));
            },
          ),
           SettingItem(
            icon: Icons.notifications_none_outlined,
            title: 'Notifications',
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => NotificationsView()));
            },
          ),
          const Divider(),
           SettingItem(
            icon: Icons.email_outlined,
            title: 'Change Email',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ChangeEmailView()),
              );
            },
          ),
          SettingItem(
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ChangePasswordView()),
              );
            },
          ),
          const Divider(),
          SettingItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => Help()));
            },
          ),
          SettingItem(
            icon: Icons.info_outline,
            title: 'About',
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => About()));
            },
          ),
        ],
      ),
    );
  }
}
