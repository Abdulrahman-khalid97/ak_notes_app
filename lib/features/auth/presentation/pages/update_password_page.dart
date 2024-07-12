
import 'package:ak_notes_app/features/auth/presentation/bodies/update_password_page_body.dart';
import 'package:flutter/material.dart';
class UpdatePasswordPage extends StatelessWidget {
  const UpdatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  const SafeArea(
        child: Scaffold(
          body: UpdatePasswordPageBody()
        ));
  }
}
