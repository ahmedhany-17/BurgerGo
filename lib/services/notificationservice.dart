class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}

class FlutterLocalNotificationsPlugin {
  void initialize(InitializationSettings initializationSettings) {}
  void show(int id, String title, String body, NotificationDetails platformChannelSpecifics) {}
}

class NotificationDetails {
  const NotificationDetails({required AndroidNotificationDetails android});
}

class AndroidNotificationDetails {
  const AndroidNotificationDetails(String s, String s2, {required Importance importance, required Priority priority});
}

class Importance {
  static var max = Importance();
}

class Priority {
  static var high = Priority();
}

class InitializationSettings {
  const InitializationSettings({required AndroidInitializationSettings android});
}

class AndroidInitializationSettings {
  const AndroidInitializationSettings(String s);
}