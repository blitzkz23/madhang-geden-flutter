import 'dart:ui';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:restaurant_app/main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    debugPrint('Alarm Fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService(Client()).restaurantList();
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(result);
  }
}
