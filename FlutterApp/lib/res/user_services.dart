import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.notification?.title);
     // showNotification(message);
    });
  }

void inItLoadNotification(BuildContext context ,RemoteMessage message) async {

  var android = const AndroidInitializationSettings("");
var initializationSettings = InitializationSettings(
  android: android,
);
  await _flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (payload){

    }
  );
}

// Future<void>showNotification(RemoteMessage message)async {

//   AndroidNotificationChannel channel = AndroidNotificationChannel(
    
//     Random.secure().nextInt(100000).toString(), 'High Importance',importance: Importance.max);
  
//   AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
//     channel.id.toString(), 
//     channel.name,
//     channelDescription: 'channel description ',
//     importance: Importance.high,
//     priority: Priority.high);

//    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(

//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true
//     );
//     NotificationDetails notificationDetails = NotificationDetails(

//     android: androidNotificationDetails,
//     iOS: darwinNotificationDetails,
//     );
    
//     Future.delayed(Duration.zero,(){
//       _flutterLocalNotificationsPlugin.show(0, message.notification?.title.toString(), message.notification?.body.toString(), notificationDetails);
//     });
// }

  Future initialize() async {
    _firebaseMessaging.getToken().then((token) {
      print('Device Token: $token');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message: ${message.notification?.body}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
    });
  }
}
