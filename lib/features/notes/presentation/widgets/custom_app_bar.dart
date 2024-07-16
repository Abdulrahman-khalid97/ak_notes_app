import 'package:ak_notes_app/app_local.dart';
import 'package:ak_notes_app/features/auth/presentation/provider/authentication_provider.dart';
import 'package:ak_notes_app/features/notes/presentation/widgets/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../core/style/text_style.dart';
import '../../../../routes/routes.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.icon, this.onIconPressed,  required this.title, required this.onSelected});

   final String title;
  final IconData icon;
 // final bool isDark;
  final void Function()? onIconPressed;
 // final void Function()? onThemeToggled;
 final void Function(int)? onSelected;
  @override
  Widget build(BuildContext context) {
    AppLocal.init(context);
    return Row(
      children: [
        Text(title, style: kTitle1Style),
        const Spacer(),
        Row(
          children: [
            CustomIcon(icon: icon, onIconPressed: onIconPressed,),
          PopupMenuButton(
                onSelected: onSelected,
                itemBuilder: (context)=> [
                  PopupMenuItem( value: 0,child: Text(AppLocal.loc.settings) ,) ,
                  PopupMenuItem( value: 1,child: Text(AppLocal.loc.signOut) ,)
                ])
          ],
        )
      ],
    );
  }
}

class CustomAppBarBack extends StatelessWidget {
  const CustomAppBarBack({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    AppLocal.init(context);
    return Row(
      children: [
        Text(title, style: kTitle1Style),
        const Spacer(),
        IconButton(onPressed: (){
          Navigator.pop(context);
        },icon:  const Icon(Icons.close)),

      ],
    );
  }
}
class CustomAppBarEdit extends StatelessWidget {
  const CustomAppBarEdit({super.key, required this.title,required this.onIconPressed});

  final String title;
  final void Function()? onIconPressed;

  @override
  Widget build(BuildContext context) {
    AppLocal.init(context);
    return Row(
      children: [
        Text(AppLocal.loc.note, style: kTitle1Style),
        const Spacer(),
        IconButton(onPressed: onIconPressed,icon:  const Icon(Icons.check)),

      ],
    );
  }
}



