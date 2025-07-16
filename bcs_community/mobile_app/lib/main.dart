import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'core/config/app_config.dart';
import 'core/services/notification_service.dart';
import 'features/auth/presentation/pages/splash_page.dart';
import 'firebase_options.dart';

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize Firebase Messaging
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  // Initialize notification service
  await NotificationService.initialize();
  
  runApp(
    const ProviderScope(
      child: BCSCommunityApp(),
    ),
  );
}

class BCSCommunityApp extends StatelessWidget {
  const BCSCommunityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BCS Community',
      debugShowCheckedModeBanner: false,
      theme: AppConfig.lightTheme,
      darkTheme: AppConfig.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashPage(),
    );
  }
}
