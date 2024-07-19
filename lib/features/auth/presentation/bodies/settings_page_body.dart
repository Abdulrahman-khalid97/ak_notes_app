import 'dart:ffi';
import 'dart:typed_data';

import 'package:ak_notes_app/app_local.dart';
import 'package:ak_notes_app/core/provider_setting.dart';
import 'package:ak_notes_app/core/style/dimensional.dart';
import 'package:ak_notes_app/features/auth/presentation/provider/authentication_provider.dart';
import 'package:ak_notes_app/features/auth/presentation/widgets/custom_icon.dart';
import 'package:ak_notes_app/features/notes/presentation/widgets/custom_app_bar.dart';

import 'package:ak_notes_app/routes/routes.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/style/color.dart';
import '../../../../core/style/text_style.dart';
import '../../data/models/user_model.dart';
import '../provider/storage_provider.dart';

class SettingsPageBody extends StatefulWidget {
  const SettingsPageBody({super.key});

  @override
  State<SettingsPageBody> createState() => _SettingsPageBodyState();
}

class _SettingsPageBodyState extends State<SettingsPageBody> {
  UserModel user = UserModel();

  String? gender, fName, lName;
  late StorageProvider _storageProvider;
  String? age;
  final GlobalKey<FormState> _frmKey = GlobalKey();
  final GlobalKey<FormState> _updateFrmKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  DateTime? _selectedDate;
  IconData? iconData;

  DateFormat formatter = DateFormat('yyyy/MM/dd');

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    user.email = context.read<AuthenticationProvider>().user!.email;
    user.id = context.read<AuthenticationProvider>().user!.uid;
    user.displayName = context.read<AuthenticationProvider>().user!.displayName;
    _storageProvider = Provider.of<StorageProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    AppLocal.init(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: kAppBarUp,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kHorizontalBodyPadding),
            child: CustomAppBarBack(title: AppLocal.loc.settings),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kHorizontalBodyPadding),
            child: Text(
              AppLocal.loc.account,
              style: kTitleHeaderStyle,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kHorizontalBodyPadding),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    await selectSource();
                    if (_storageProvider.img != null) {
                      saveImage(_storageProvider.img!);
                    }
                  },
                  child: context
                              .watch<AuthenticationProvider>()
                              .user!
                              .photoURL !=
                          null
                      ? CircleAvatar(
                          radius: 32,
                          backgroundImage: NetworkImage(context
                              .watch<AuthenticationProvider>()
                              .user!
                              .photoURL!),
                        )
                      : const CircleAvatar(
                          radius: 32,
                          backgroundImage:
                              AssetImage("assets/images/user-avatar.png")),
                ),

                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context
                          .read<AuthenticationProvider>()
                          .user!
                          .displayName!,
                      style: kTitle2Style,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      context.read<AuthenticationProvider>().user!.email!,
                      style: kSubTitleStyle,
                    )
                  ],
                ),

              ],
            ),
          ),
          const SizedBox(height: 5,),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteManager.updatePasswordPage);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kHorizontalBodyPadding, vertical: kSettingItemPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const  Icon(Icons.password_outlined ,  color: Colors.grey,),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocal.loc.password,
                        style: kTitle2Style,
                      ),
                     const  SizedBox(height: 5,),
                      Text(
                        AppLocal.loc.changePassword,
                        style: kSubTitleStyle,
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),

          InkWell(
            onTap: () async {
              await context
                  .read<AuthenticationProvider>()
                  .signOut()
                  .then((value) {
                Navigator.of(context).pop();
                Navigator.popAndPushNamed(context, RouteManager.loginPage);
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kHorizontalBodyPadding, vertical: kSettingItemPadding),
              child: Row(
                children: [
                  const  Icon(Icons.logout_outlined ,  color: Colors.grey,),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    AppLocal.loc.signOut,
                    style: kTitle2Style,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: kSectionTop/2,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalBodyPadding , vertical: kSettingItemPadding/2),
            child: Text(
              AppLocal.loc.appSettings,
              style: kTitleHeaderStyle,
            ),
          ),
          InkWell(
            onTap: (){

              Navigator.pushNamed(context, RouteManager.changeLangPage);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalBodyPadding , vertical: kSettingItemPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const  Icon(Icons.language  ,  color: Colors.grey,),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocal.loc.language,
                        style: kTitle2Style,
                      ),
                      const  SizedBox(height: 5,),
                      Text(
                        AppLocal.loc.changeAppLanguage,
                        style: kSubTitleStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalBodyPadding , vertical: kSettingItemPadding),
            child: Row(
              children: [
              const  Icon(Icons.dark_mode_outlined  ,  color: Colors.grey,),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocal.loc.darkMode,
                      style: kTitle2Style,
                    ),
                    const  SizedBox(height: 5,),
                    Text(
                      context.watch<SettingProvider>().isDarkMode!?AppLocal.loc.dark: AppLocal.loc.light,
                      style: kSubTitleStyle,
                    ),
                  ],
                ),
                const Spacer(),

                Transform.scale(
                  scale: 0.85,
                  child: Switch(

                      value: context.watch<SettingProvider>().isDarkMode!,
                      onChanged: (value) {
                        context.read<SettingProvider>().toggleTheme(value);
                      }),
                ),

              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalBodyPadding , vertical: kSettingItemPadding),
            child: Row(
              children: [
                const  Icon(Icons.help_outline , color: Colors.grey,),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  AppLocal.loc.help,
                  style: kTitle2Style,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future selectSource() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          AppLocal.init(context);
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                     Text(
                     AppLocal.loc.selectImage,
                      style: kTitleHeaderStyle,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // context.read<StorageProvider>().selectImage(ImageSource.gallery);
                            await _storageProvider
                                .selectImage(ImageSource.gallery);
                            if (context.mounted) Navigator.of(context).pop();
                          },
                          child:  Card(
                            child: Padding(
                              padding:const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                 const  Icon(
                                    Icons.image,
                                    size: 56,
                                  ),
                                  Text(  AppLocal.loc.gallery)
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _storageProvider
                                .selectImage(ImageSource.camera);
                            if (context.mounted) Navigator.of(context).pop();
                          },
                          child:  Card(
                            child: Padding(
                              padding:const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                const  Icon(
                                    Icons.camera,
                                    size: 56,
                                  ),
                                  Text(  AppLocal.loc.camera)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  saveImage(Uint8List img) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent.withOpacity(0.8),
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.transparent.withOpacity(0.4),
            child: SizedBox(
                height: 200,
                width: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    !context.watch<StorageProvider>().isUploading
                        ? Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.close)))
                        : const SizedBox(),
                    Positioned(
                      top: 16,
                      child: CircleAvatar(
                        radius: 56,
                        backgroundImage: MemoryImage(img),
                      ),
                    ),
                    context.watch<StorageProvider>().isUploading
                        ? Positioned(
                            top: 40,
                            child: SizedBox(
                              height: 60,
                              width: 60,
                              child: CircularProgressIndicator(
                                value: context
                                    .watch<StorageProvider>()
                                    .uploadProgress,
                              ),
                            ))
                        : const SizedBox(),
                    context.watch<StorageProvider>().isUploading
                        ? Positioned(
                            top: 60,
                            child: Text(
                              "${context.watch<StorageProvider>().uploadProgress}%",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ))
                        : const SizedBox(),
                    !context.watch<StorageProvider>().isUploading
                        ? Positioned(
                            bottom: 16,
                            child: ElevatedButton(
                                onPressed: () async {
                                  await _storageProvider.uploadImageProfile();
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                    await context
                                        .read<AuthenticationProvider>()
                                        .updateProfileImage(
                                            _storageProvider.imageUrl!);
                                  }
                                  if (context.mounted) {
                                    _storageProvider.resetVariable();
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text(AppLocal.loc.update)))
                        : const SizedBox(),
                  ],
                )),
          );
        });
  }
}
