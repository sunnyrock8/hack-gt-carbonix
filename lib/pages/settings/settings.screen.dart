import 'package:carbonix/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.blue,
      // appBar: toolbarWidget(showBack: true),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  // ... existing widgets ...
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => context.setLocale(Locale('en')),
                        child: Text('English'),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => context.setLocale(Locale('hi')),
                        child: Text('हिंदी'),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => context.setLocale(Locale('mr')),
                        child: Text('मराठी'),
                      ),
                    ],
                  ),
                  // ... existing widgets ...
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
