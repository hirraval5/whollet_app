import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'log.dart';

@pragma("vm:entry-point")
Future<void> _onBackgroundMessage(RemoteMessage message) async {
  Log.debug("------------FirebaseMessaging.onBackgroundMessage------------");
  Log.debug("Data");
  Log.debug(message.toMap());
}

final class FirebaseNotificationHelper {
  FirebaseNotificationHelper._internal() {
    _initialize();
  }

  static FirebaseNotificationHelper? instance;

  factory FirebaseNotificationHelper.getInstance() => instance ??= FirebaseNotificationHelper._internal();

  late final FlutterLocalNotificationsPlugin _notificationPlugin = FlutterLocalNotificationsPlugin();

  Future<void> _initialize() async {
    Log.debug("------------FirebaseNotificationHelper------------");
    await _initializeNotification();
    await _resolvePermission();
    await _resolvePlatformImplementation();
    _configureMessaging();
  }

  Future<void> _initializeNotification() async {
    const android = AndroidInitializationSettings("ic_launcher");
    const iOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: android,
      iOS: iOS,
    );
    await _notificationPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
  }

  final _messaging = FirebaseMessaging.instance;
  final StreamController<NotificationResponse> _streamController = StreamController<NotificationResponse>.broadcast();

  Stream<NotificationResponse> get onDidReceiveNotificationResponse => _streamController.stream;

  Future<bool> _resolvePermission() async {
    await _messaging.requestPermission(sound: true, alert: true, badge: true);
    return true;
  }

  final _notificationChannel = "shoppe.general";
  final _androidNotificationIcon = "ic_launcher";

  Future<void> _resolvePlatformImplementation() async {
    final channel = AndroidNotificationChannel(_notificationChannel, "General Notification");
    await _notificationPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  }

  void _onDidReceiveNotificationResponse(NotificationResponse details) {
    _streamController.add(details);
  }

  Future<void> _showNotification({required String title, String? body, String? payload}) async {
    final hasPermission = await _resolvePermission();
    if (!hasPermission) return;
    final androidDetails = AndroidNotificationDetails(
      _notificationChannel,
      "General Notifications",
      icon: _androidNotificationIcon,
    );
    final iosDetails = DarwinNotificationDetails(categoryIdentifier: _notificationChannel);
    final notificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);
    return _notificationPlugin.show(
      Object.hashAll([title, body, payload]),
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  void _configureMessaging() {
    FirebaseMessaging.onMessage.listen(_onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  }

  Future<void> _onMessage(RemoteMessage message) async {
    Log.debug("------------FirebaseMessaging.onMessage------------");
    Log.debug("Data");
    Log.debug(message.toMap());
    if (message.notification != null) {
      final notification = message.notification;
      await _showNotification(
        title: notification?.title ?? "",
        body: notification?.body,
        payload: jsonEncode(message.data),
      );
    }
  }

  void _onMessageOpenedApp(RemoteMessage message) {
    Log.debug("------------FirebaseMessaging.onMessageOpenedApp------------");
    Log.debug("Data");
    Log.debug(message.toMap());
  }
}
