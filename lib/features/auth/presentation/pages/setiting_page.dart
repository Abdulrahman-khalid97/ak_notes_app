import 'package:ak_notes_app/features/auth/presentation/bodies/settings_page_body.dart';
import 'package:flutter/material.dart';
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
          body: SettingsPageBody(),
        ));
  }
}
