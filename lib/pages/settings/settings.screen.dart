import 'package:carbonix/theme/theme.dart';
import 'package:flutter/material.dart';

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
            children: [],
          ),
        ),
      ),
    );
  }
}
