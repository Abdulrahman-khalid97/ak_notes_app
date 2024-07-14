import 'dart:typed_data';

import 'package:ak_notes_app/app_local.dart';
import 'package:ak_notes_app/core/provider_setting.dart';
import 'package:ak_notes_app/features/auth/presentation/provider/authentication_provider.dart';
import 'package:ak_notes_app/features/auth/presentation/widgets/custom_icon.dart';
import 'package:ak_notes_app/features/notes/presentation/widgets/custom_app_bar.dart';

import 'package:ak_notes_app/routes/routes.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../core/dialogs/snack_bar_dialoge.dart';
import '../../../../core/error/error_message_filter.dart';
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
   SettingProvider? p ;

  DateFormat formatter = DateFormat('yyyy/MM/dd');

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    user.email = context.read<AuthenticationProvider>().user!.email;
    user.id = context.read<AuthenticationProvider>().user!.uid;
    user.displayName = context.read<AuthenticationProvider>().user!.displayName;
    _storageProvider = Provider.of<StorageProvider>(context , listen: false);
  }


  @override
  Widget build(BuildContext context) {
    AppLocal.init(context);
    // userProvider.clearValue();

    return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
            CustomAppBarBack(title: AppLocal.loc.settings),
              const SizedBox(
                height: 24,
              ),
              Text(AppLocal.loc.account, style: kTitleHeaderStyle, ),
              const SizedBox(height: 8,),
          
              Row(children: [
                GestureDetector(onTap: () async {
                  await selectSource();
                if(_storageProvider.img !=null){
                  saveImage(_storageProvider.img!);
                }
          
          
                },
                child: context.watch<AuthenticationProvider>().user!.photoURL !=null?  CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(context.watch<AuthenticationProvider>().user!.photoURL!),
                ):
                const CircleAvatar(
                    radius: 64,
                    backgroundImage: AssetImage("assets/images/user-avatar.png" )),),
          
               const SizedBox(width: 16,) ,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.read<AuthenticationProvider>().user!.displayName! , style: kTitle2Style,) ,
                    const SizedBox(height: 5,),
                    Text(context.read<AuthenticationProvider>().user!.email! , style: kSubTitleStyle,)
                  ],),
          // const Spacer(),
          //  CustomIcon(icon: context.watch<SettingProvider>().local! ==AppLocal.loc.ar? Icons.chevron_left_outlined :Icons.chevron_right_outlined , onIconPressed: (){
          //
          //    Navigator.pushNamed(context, RouteManager.accountDetailsPage);
          //  },)
              ],) ,
              const SizedBox(height: 8,),
              Row(
                children: [
                  const CustomIcon(icon: Icons.password_outlined),
                  const SizedBox(width: 10,) ,
                  Text(AppLocal.loc.password , style: kTitle2Style, ),
                  const Spacer() ,
                  CustomIcon(icon:context.read<SettingProvider>().local! ==AppLocal.loc.en?  Icons.chevron_right_outlined:Icons.chevron_left_outlined , onIconPressed: () async{
                   Navigator.pushNamed(context, RouteManager.updatePasswordPage);
                  },) ,
          
                ],
              ),
              const SizedBox(height: 8,),
              Row(
                children: [
                  const CustomIcon(icon: Icons.logout),
                  const SizedBox(width: 10,) ,
                  Text(AppLocal.loc.signOut , style: kTitle2Style, ),
                  const Spacer() ,
                  CustomIcon(icon:context.read<SettingProvider>().local! ==AppLocal.loc.en?  Icons.chevron_right_outlined:Icons.chevron_left_outlined , onIconPressed: () async{
                    await context.read<AuthenticationProvider>().signOut().then((value){
                      Navigator.popAndPushNamed(context, RouteManager.loginPage);
                    }).catchError((error){
                      SnackBarDialoge.showSnackBar(context , message: errorMessage(error) ,
                          bgColor: Colors.red, messageColor: kWhiteColor ,icon: Icons.error_outline);
                    });
                  },) ,
          
                ],
              ),
            const   SizedBox(height: 8,),
              Text(AppLocal.loc.appSettings , style: kTitleHeaderStyle, ),
             const  SizedBox(height: 8,),
              Row(
                children: [
                  const CustomIcon(icon: Icons.language),
                  const SizedBox(width: 10,) ,
                  Text(AppLocal.loc.language , style: kTitle2Style, ),
                  const Spacer() ,
                  Text(context.watch<SettingProvider>().local! , style: kSubTitleStyle,) ,
                  const SizedBox(width: 16,) ,
                   CustomIcon(icon:  context.watch<SettingProvider>().local! ==AppLocal.loc.ar? Icons.chevron_left_outlined :Icons.chevron_right_outlined, onIconPressed: (){
                    Navigator.pushNamed(context, RouteManager.changeLangPage);
                  },) ,
          
                ],
              ),
              const SizedBox(height: 8,),
              Row(
                children: [
                  const CustomIcon(icon: Icons.dark_mode_outlined),
                  const SizedBox(width: 10,) ,
                  Text(AppLocal.loc.darkMode , style: kTitle2Style, ),
                  const Spacer() ,
                  Text(context.watch<SettingProvider>().isDarkMode!? AppLocal.loc.on : AppLocal.loc.off, style: kSubTitleStyle,) ,
                  const SizedBox(width: 16,) ,
                  Switch(
                    activeColor: Colors.blueGrey,
                      inactiveTrackColor: Colors.grey,
                      value:  context.watch<SettingProvider>().isDarkMode!, onChanged: (value){
                    context.read<SettingProvider>().toggleTheme(value);
          
                  }
                  ),
          
                ],
              ),
              const SizedBox(height: 8,),
              Row(
                children: [
                 const CustomIcon(icon: Icons.help),
                  const SizedBox(width: 8,) ,
                  Text(AppLocal.loc.help , style: kTitle2Style, ),
                  const Spacer() ,
                   CustomIcon(icon: context.read<SettingProvider>().local=="ar"? Icons.chevron_left_outlined :Icons.chevron_right_outlined) ,
          
                ],
              ),
          
            ],
          ),
        ),

    );
  }
   Future selectSource(){
    return showDialog(
        context :context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10) ,

            ),
            child:  SizedBox(
              height: 200,
              child:Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const Text("Select Image From" , style: kTitleHeaderStyle,) ,
                    const SizedBox(height: 24,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: ()async{
                             // context.read<StorageProvider>().selectImage(ImageSource.gallery);
                            await _storageProvider.selectImage(ImageSource.gallery);
                            if (context.mounted) Navigator.of(context).pop();
                          },
                          child: const Card(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Icon(Icons.image , size: 56,),
                                  Text("Gallery")
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async{

                            await _storageProvider.selectImage(ImageSource.camera);
                            if (context.mounted) Navigator.of(context).pop();
                          },
                          child: const Card(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Icon(Icons.camera , size: 56,),
                                  Text("Camera")
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ) ,
            ),
          );
        }
    );
  }

  saveImage(Uint8List  img){
    return  showDialog(
        context :context,
        barrierDismissible: false,
        barrierColor: Colors.transparent.withOpacity(0.8),
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10) ,
            ),
            backgroundColor: Colors.transparent.withOpacity(0.4),
            child: SizedBox(
              height: 200,
                width: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  !context.watch<StorageProvider>().isUploading?Positioned(
                    right: 0,
                      top: 0,
                      child: IconButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, icon:const Icon(Icons.close))):const SizedBox(),
                  Positioned(
                    top: 16,
                    child: CircleAvatar(
                      radius: 56,
                      backgroundImage: MemoryImage(img),
                    ),
                  ) ,
                    context.watch<StorageProvider>().isUploading?  Positioned(
                      top: 40,
                      child:SizedBox(height: 60 , width: 60, child: CircularProgressIndicator(
                        value:context.watch<StorageProvider>().uploadProgress ,
                      ),)):const SizedBox(),
                  context.watch<StorageProvider>().isUploading? Positioned(
                      top: 60,

                      child:Text( "${ context.watch<StorageProvider>().uploadProgress}%" , style:  TextStyle(color: Theme.of(context).colorScheme.primary),)):const SizedBox(),
                  !context.watch<StorageProvider>().isUploading?  Positioned(
                      bottom: 16,
                      child: ElevatedButton(onPressed: ()async{

                        await _storageProvider.uploadImageProfile();
                        if (context.mounted)  await context.read<AuthenticationProvider>().updateProfileImage(_storageProvider.imageUrl!);

                        _storageProvider.resetVariable();
                        if (context.mounted)  Navigator.of(context).pop();
                      }, child:  Text(AppLocal.loc.update))):const SizedBox(),

                ],
              )
            ),
          );
        }
    );
  }
}
