
import 'package:ak_notes_app/views/widgtes/custom_app_bar.dart';
import 'package:ak_notes_app/views/widgtes/settings_view_body.dart';
import 'package:flutter/material.dart';
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  SettingsViewBody()
    );
  }
}
