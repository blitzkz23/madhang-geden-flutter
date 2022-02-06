import 'package:flutter/cupertino.dart';

import 'package:flutter/widgets.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  String _message = '';
  String get message => _message;

  Future<bool> scheduledRecommender(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      debugPrint('SchedulingProvider: Scheduling Recommender Activated');
      _message = "Rekomendasi harian telah diaktifkan.";
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      debugPrint('SchedulingProvider: Scheduling Recommender Deactivated.');
      _message = "Rekomendasi harian telah dinon-aktifkan";
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
