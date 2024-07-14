
import 'package:ak_notes_app/features/auth/presentation/bodies/account_details_page_body.dart';
import 'package:flutter/material.dart';
class AccountDetailsPage extends StatelessWidget {
  const AccountDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
          body: AccountDetailsPageBody(),
        ));
  }
}
