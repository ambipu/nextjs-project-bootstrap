import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  
  static Future<void> initialize() async {
    // Request permission for notifications
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    
    if (kDebugMode) {
      print('User granted permission: ${settings.authorizationStatus}');
    }
    
    // Get the token
    String? token = await _firebaseMessaging.getToken();
    if (kDebugMode) {
      print('FCM Token: $token');
    }
    
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
      }
      
      if (message.notification != null) {
        if (kDebugMode) {
          print('Message also contained a notification: ${message.notification}');
        }
        // Show local notification here
        _showLocalNotification(message);
      }
    });
    
    // Handle notification taps
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('A new onMessageOpenedApp event was published!');
      }
      // Handle navigation based on message data
      _handleNotificationTap(message);
    });
    
    // Check for initial message (app opened from terminated state)
    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }
  
  static Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }
  
  static Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }
  
  static Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
  
  static void _showLocalNotification(RemoteMessage message) {
    // Implement local notification display
    // You can use flutter_local_notifications package for this
    if (kDebugMode) {
      print('Showing notification: ${message.notification?.title}');
    }
  }
  
  static void _handleNotificationTap(RemoteMessage message) {
    // Handle navigation based on notification data
    if (kDebugMode) {
      print('Notification tapped: ${message.data}');
    }
    
    // Example: Navigate to specific screen based on message data
    String? type = message.data['type'];
    String? chatId = message.data['chatId'];
    String? userId = message.data['userId'];
    
    switch (type) {
      case 'chat_message':
        // Navigate to chat screen
        if (kDebugMode) {
          print('Navigate to chat: $chatId');
        }
        break;
      case 'member_update':
        // Navigate to member profile
        if (kDebugMode) {
          print('Navigate to member profile: $userId');
        }
        break;
      case 'admin_broadcast':
        // Show admin message
        if (kDebugMode) {
          print('Show admin broadcast');
        }
        break;
      default:
        // Navigate to home screen
        if (kDebugMode) {
          print('Navigate to home');
        }
    }
  }
}
