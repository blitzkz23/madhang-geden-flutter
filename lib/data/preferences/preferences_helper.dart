import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;
  static const dailyReminder = 'DAILY_REMINDER';

  PreferencesHelper(this.sharedPreferences);

  Future<bool> get isDailyReminderActive async {
    final SharedPreferences prefs = await sharedPreferences;
    return prefs.getBool(dailyReminder) ?? false;
  }

  void setDailyReminder(bool value) async {
    final SharedPreferences prefs = await sharedPreferences;
    prefs.setBool(dailyReminder, value);
  }
}
