import 'package:ak_notes_app/app_local.dart';
import 'package:ak_notes_app/features/auth/presentation/provider/authentication_provider.dart';
import 'package:ak_notes_app/features/notes/presentation/widgets/custom_app_bar.dart';

import 'package:ak_notes_app/setting_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../data/models/user_model.dart';

class SettingsPageBody extends StatefulWidget {
  const SettingsPageBody({super.key});

  @override
  State<SettingsPageBody> createState() => _SettingsPageBodyState();
}

class _SettingsPageBodyState extends State<SettingsPageBody> {
  UserModel user = UserModel();

  String? gender, fName, lName;

  String? age;
  final GlobalKey<FormState> _frmKey = GlobalKey();
  final GlobalKey<FormState> _updateFrmKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  int? _selectedOption = -1;
  DateTime? _selectedDate;

  DateFormat formatter = DateFormat('yyyy/MM/dd');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user.email = context.read<AuthenticationProvider>().user!.email;
    user.id = context.read<AuthenticationProvider>().user!.uid;
    user.displayName = context.read<AuthenticationProvider>().user!.displayName;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocal.init(context);
    // userProvider.clearValue();

    return ChangeNotifierProvider(
      create: (context) => context.watch<AuthenticationProvider>(),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CustomAppBarBack(title: AppLocal.loc.settings),
          ),
          const SizedBox(
            height: 24,
          ),
          Center(
            child: Stack(
              children: [
                const CircleAvatar(
                  radius: 64,
                ),
                Positioned(
                  bottom: -4,
                  right: -8,
                  child: IconButton(
                    icon: const Icon(
                      Icons.add_photo_alternate_rounded,
                      size: 32,
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(FirebaseAuth.instance.currentUser!.displayName.toString()),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
