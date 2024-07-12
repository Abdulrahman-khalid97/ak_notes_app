import 'package:ak_notes_app/app_local.dart';
import 'package:ak_notes_app/core/provider_setting.dart';
import 'package:ak_notes_app/features/auth/presentation/provider/authentication_provider.dart';
import 'package:ak_notes_app/features/auth/presentation/widgets/custom_icon.dart';
import 'package:ak_notes_app/features/notes/presentation/widgets/custom_app_bar.dart';

import 'package:ak_notes_app/routes/routes.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../core/dialogs/snack_bar_dialoge.dart';
import '../../../../core/error/error_message_filter.dart';
import '../../../../core/style/text_style.dart';
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
  }


  @override
  Widget build(BuildContext context) {
    AppLocal.init(context);
    // userProvider.clearValue();

    return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
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

              Image.asset("assets/images/user-avatar.png" , height: 56 , width: 56,),
             const SizedBox(width: 16,) ,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.read<AuthenticationProvider>().user!.displayName! , style: kTitle2Style,) ,
                  const SizedBox(height: 5,),
                  Text(context.read<AuthenticationProvider>().user!.email! , style: kSubTitleStyle,)
                ],),
        const Spacer(),
         CustomIcon(icon: context.watch<SettingProvider>().local! ==AppLocal.loc.ar? Icons.chevron_left_outlined :Icons.chevron_right_outlined)
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
                    print(error.runtimeType);
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
                CustomIcon(icon: Icons.dark_mode_outlined),
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
                CustomIcon(icon: Icons.help),
                const SizedBox(width: 8,) ,
                Text(AppLocal.loc.help , style: kTitle2Style, ),
                const Spacer() ,
                 CustomIcon(icon: context.read<SettingProvider>().local=="ar"? Icons.chevron_left_outlined :Icons.chevron_right_outlined) ,

              ],
            ),

          ],
        ),

    );
  }
}
