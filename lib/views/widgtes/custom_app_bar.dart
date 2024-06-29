import 'package:ak_notes_app/app_local.dart';
import 'package:ak_notes_app/controllers/auth_controller.dart';
import 'package:ak_notes_app/views/constants/font_style.dart';
import 'package:ak_notes_app/views/login_view.dart';
import 'package:ak_notes_app/views/settings_view.dart';
import 'package:flutter/material.dart';

import 'custom_icon.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.tille, required this.icon, this.onIconPressed, this.onThemeToggled,   this.isDark=true});

  final String tille;
  final IconData icon;
  final bool isDark;

  final void Function()? onIconPressed;
  final void Function()? onThemeToggled;
  @override
  Widget build(BuildContext context) {
    AppLocal.init(context);
    return Row(
      children: [
        Text(tille , style: kTitle1Style),
        const Spacer(),
        Row(
          children: [
            tille==AppLocal.loc.note? IconButton(onPressed: onThemeToggled, icon: !isDark? const Icon(Icons.dark_mode): const Icon(Icons.light_mode)): Container(),
            const SizedBox(width: 8,),
             CustomIcon(icon: icon, onIconPressed: onIconPressed,),
            tille==AppLocal.loc.note? PopupMenuButton(
              onSelected: (item){
              switch(item){
                case 0 :
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const SettingsView()));
                  break;
                case 1 :
                  AuthController().signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                  const LoginView()));

                  break;
              }
              },
                itemBuilder: (context)=> [
               PopupMenuItem( value: 0,child: Text(AppLocal.loc.settings) ,) ,
                    PopupMenuItem( value: 1,child: Text(AppLocal.loc.signOut) ,)
            ]) : Container()
             ],
        )
      ],
    );
  }
}
