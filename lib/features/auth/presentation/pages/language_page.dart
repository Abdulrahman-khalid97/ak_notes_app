import 'package:ak_notes_app/features/auth/presentation/bodies/language_page_body.dart';
import 'package:flutter/material.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child:
    Scaffold(
      body: LanguagePageBody(),
    ));
  }
}
