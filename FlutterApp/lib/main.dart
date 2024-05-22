import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hospital/res/user_services.dart';
import 'package:hospital/screens/Splash.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  PushNotificationHandler().firebaseInit();
  PushNotificationHandler().initialize();
   runApp(MyApp());
}

Future<void> backgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Splash(),
    );
  }
}
