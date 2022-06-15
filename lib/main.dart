import 'package:checkbox_multiple/model/notification_setting.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final allowNotifications = NotificationSetting(title: 'Allow Notifications');

  final notifications = [
    NotificationSetting(title: 'Show Message'),
    NotificationSetting(title: 'Show Group'),
    NotificationSetting(title: 'Show Calling'),
  ];

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Checkbo Multiple'),
            centerTitle: true,
          ),
          body: ListView(
            children: [
              buildToggleCheckbox(allowNotifications),
              Divider(),
              ...notifications.map(buildSingleCheckbox).toList(),
            ],
          ),
        ),
      );

  Widget buildToggleCheckbox(NotificationSetting notification) => buildCheckbox(
      notification: notification,
      onClicked: () {
        final newValue = !notification.value;

        setState(() {
          allowNotifications.value = newValue;
          notifications.forEach((notification) {
            notification.value = newValue;
          });
        });
      });

  Widget buildSingleCheckbox(NotificationSetting notification) => buildCheckbox(
        notification: notification,
        onClicked: () {
          setState(() {
            final newValue = !notification.value;
            notification.value = newValue;

            if (!newValue) {
              allowNotifications.value = false;
            } else {
              final allow =
                  notifications.every((notification) => notification.value);
              allowNotifications.value = allow;
            }
          });
        },
      );

  Widget buildCheckbox({
    required NotificationSetting notification,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        onTap: onClicked,
        leading: Checkbox(
          value: notification.value,
          onChanged: (value) => onClicked(),
        ),
        title: Text(
          notification.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
}
