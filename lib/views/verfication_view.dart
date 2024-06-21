
import 'package:ak_notes_app/controllers/auth_controller.dart';
import 'package:ak_notes_app/views/widgtes/verification_body_view.dart';
import 'package:flutter/material.dart';

class VerficationView extends StatelessWidget {
  const VerficationView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: VerificationBodyView(),
    );
  }
}
