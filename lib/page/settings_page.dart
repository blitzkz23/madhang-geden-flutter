import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
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
                child: ListView(
                  children: [
                    Material(
                      child: ListTile(
                        title: const Text('Jadwal Harian'),
                        trailing: Consumer<SchedulingProvider>(
                          builder: (context, scheduled, _) {
                            return Switch.adaptive(
                              value: false,
                              onChanged: (value) async {
                                // if (Platform.isIOS) {
                                //   customDialog(context);
                                // } else {
                                //   scheduled.scheduledNews(value);
                                //   provider.enableDailyNews(value);
                              },
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
