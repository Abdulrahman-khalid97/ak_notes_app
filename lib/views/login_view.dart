import 'package:ak_notes_app/controllers/auth_controller.dart';
import 'package:ak_notes_app/views/widgtes/login_view_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginViewBody();
  }
}

