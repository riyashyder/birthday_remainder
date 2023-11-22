import 'package:birthday_remainder_final/alert_dialog_settings.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'alert_dialog_settings_shared_preferences.dart';

void main() {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'high_importance_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification Channel For basic tests',
      )
    ],
  );
  runApp(const MyApplication());
}

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Homepagemain(),
    );
  }
}

class Homepagemain extends StatefulWidget {
  const Homepagemain({super.key});

  @override
  State<Homepagemain> createState() => _HomepagemainState();
}

class _HomepagemainState extends State<Homepagemain> {
  @override
  void initState(){
    AwesomeNotifications().isNotificationAllowed().then((isAllowed){
      if(!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }
  triggerNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'high_importance_channel',
        title: 'Simple Notification',
        body: 'Today is your Friend Birthday',
      ),
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Birthday Remainder'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.settings,
                      size: 20,
                    ),
                    SizedBox(width: 8), // Add some spacing between icon and text
                    Text(
                      'Settings',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                value: 1,
              ),
            ],
            onSelected: (value) {
              if (value == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AlertDialogSettings(),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: triggerNotification,
          child: Text('Trigger Notification'),
        ),
      ),
    );
  }

}
