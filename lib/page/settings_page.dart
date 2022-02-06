import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';

class SettingsPage extends StatefulWidget {
  static const String pageTitle = 'Settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Pengaturan',
                style: poppinsTheme.headline5
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Consumer<PreferencesProvider>(
                  builder: (context, provider, child) {
                    return ListView(
                      children: [
                        Material(
                          child: ListTile(
                            title: const Text('Rekomendasi Harian'),
                            trailing: Consumer<SchedulingProvider>(
                              builder: (context, scheduled, _) {
                                return Switch.adaptive(
                                  value: provider.isDailyReminderActive,
                                  onChanged: (value) async {
                                    scheduled.scheduledRecommender(value);
                                    provider.enableDailyReminder(value);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          scheduled.message,
                                          style: poppinsTheme.subtitle1
                                              ?.copyWith(color: Colors.white),
                                        ),
                                        backgroundColor: kRedPrimary,
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
