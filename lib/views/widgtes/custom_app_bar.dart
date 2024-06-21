import 'package:ak_notes_app/controllers/auth_controller.dart';
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
    return Row(
      children: [
        Text(tille , style: TextStyle(
          fontSize: 28
        ),),
        Spacer(),
        Row(
          children: [
            tille=="Note"? IconButton(onPressed: onThemeToggled, icon: !isDark? Icon(Icons.dark_mode): Icon(Icons.light_mode)): Container(),
            const SizedBox(width: 8,),
             CustomIcon(icon: icon, onIconPressed: onIconPressed,),
            tille=="Note"? PopupMenuButton(
              onSelected: (item){
              switch(item){
                case 0 :
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsView()));
                  break;
                case 1 :
                  AuthController().signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  LoginView()));

                  break;
              }
              },
                itemBuilder: (context)=>[
              PopupMenuItem(child: Text("Settings") , value: 0,) ,
                  PopupMenuItem(child: Text("SignOut") , value: 1,)
            ]) :Container()
             ],
        )
      ],
    );
  }
}
