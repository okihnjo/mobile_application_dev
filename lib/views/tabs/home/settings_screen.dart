import 'package:flutter/material.dart';
import 'package:saloon_app/views/tabs/home/widgets/settings_ui.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const String pageName = "SettingsScreen";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SettingsUi(),
    );
  }
}
