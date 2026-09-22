import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/features/auth/domain/usecases/update_fcm_token_usecase.dart';
import 'package:sheshield/features/sos/presentation/screens/sos_alarm_screen.dart';

const _alarmChannelId = 'sos_alarm_channel';

final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

/// Runs in its own background isolate -- a fresh Dart VM sharing none of
/// the running app's state -- whenever a push arrives while the app is
/// backgrounded or fully killed, so it cannot push a route or touch
/// [DeviceAlarmService] the way the foreground path does. Instead it shows
/// a full-screen, alarm-channel local notification: the same mechanism an
/// incoming-call UI uses to wake the screen and launch the app on its own.
/// Must be a top-level function (not a method) -- that's an FCM/Flutter
/// requirement for background isolate entry points.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.data['type'] != 'sos_alarm') return;
  await _showAlarmNotification(message.data);
}

Future<void> _showAlarmNotification(Map<String, dynamic> data) async {
  await _localNotifications.initialize(
    settings: const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
  );

  const details = AndroidNotificationDetails(
    _alarmChannelId,
    'SOS Alarm',
    channelDescription: "Alerts you the instant a trusted contact sends an SOS.",
    importance: Importance.max,
    priority: Priority.max,
    category: AndroidNotificationCategory.alarm,
    fullScreenIntent: true,
    ongoing: true,
    autoCancel: false,
    sound: RawResourceAndroidNotificationSound('sos_alarm'),
    audioAttributesUsage: AudioAttributesUsage.alarm,
  );

  await _localNotifications.show(
    id: 0,
    title: 'SOS ALERT',
    body: '${data['senderName'] ?? 'A trusted contact'} needs help right now.',
    notificationDetails: const NotificationDetails(android: details),
    payload: jsonEncode(data),
  );
}

/// Wires FCM (push delivery + this device's token) and local notifications
/// (what actually alarms the phone while the app isn't already open)
/// together. Call [initialize] once from main(), after Firebase.initializeApp
/// -- deliberately not called yet anywhere in this codebase until a real
/// Firebase project exists (see the FCM_PROJECT_ID/FCM_CREDENTIALS_PATH
/// backend config); calling it before then would crash on startup.
class PushService {
  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await FirebaseMessaging.instance.requestPermission(alert: true, badge: true, sound: true);

    await _localNotifications.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
    await _createAlarmChannel();

    // App was fully killed and got launched by tapping the alarm
    // notification -- onMessageOpenedApp below only fires for a
    // background (not killed) app, so this covers the cold-start case.
    final launchDetails = await _localNotifications.getNotificationAppLaunchDetails();
    final launchPayload = launchDetails?.notificationResponse?.payload;
    if ((launchDetails?.didNotificationLaunchApp ?? false) && launchPayload != null) {
      _openAlarmScreen(jsonDecode(launchPayload) as Map<String, dynamic>);
    }

    FirebaseMessaging.onMessage.listen((message) {
      if (message.data['type'] != 'sos_alarm') return;
      // App is already in the foreground: skip the notification-tray
      // round trip and go straight to the alarm screen.
      _openAlarmScreen(message.data);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.data['type'] != 'sos_alarm') return;
      _openAlarmScreen(message.data);
    });

    await _registerToken();
    FirebaseMessaging.instance.onTokenRefresh.listen((_) => _registerToken());
  }

  /// Re-sends this device's current token. Registration at [initialize]
  /// time silently fails (best-effort) if nobody's signed in yet -- call
  /// this again right after a successful sign in/sign up so a fresh
  /// install doesn't have to wait for the next natural token refresh.
  Future<void> registerTokenNow() => _registerToken();

  Future<void> _createAlarmChannel() async {
    const channel = AndroidNotificationChannel(
      _alarmChannelId,
      'SOS Alarm',
      description: "Alerts you the instant a trusted contact sends an SOS.",
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound('sos_alarm'),
      audioAttributesUsage: AudioAttributesUsage.alarm,
    );
    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> _registerToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token == null) return;
    try {
      await getIt<UpdateFcmTokenUseCase>().call(token);
    } catch (_) {
      // Best-effort -- retried on the next app start or token refresh.
    }
  }

  void _onNotificationTapped(NotificationResponse response) {
    final payload = response.payload;
    if (payload == null) return;
    _openAlarmScreen(jsonDecode(payload) as Map<String, dynamic>);
  }

  void _openAlarmScreen(Map<String, dynamic> data) {
    final senderName = data['senderName'] as String? ?? 'A trusted contact';
    final lat = double.tryParse(data['latitude']?.toString() ?? '') ?? 0.0;
    final lng = double.tryParse(data['longitude']?.toString() ?? '') ?? 0.0;
    rootNavigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => SosAlarmScreen(senderName: senderName, latitude: lat, longitude: lng),
        fullscreenDialog: true,
      ),
    );
  }
}
