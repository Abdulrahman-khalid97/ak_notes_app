
import 'package:ak_notes_app/app_local.dart';
import 'package:flutter/material.dart';
class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.icon, this.onIconPressed});

  final IconData icon;
  final void Function()? onIconPressed;
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 46,
      width: 46,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0),
        borderRadius: BorderRadius.circular(16),

      ),
      child: IconButton(
        onPressed: onIconPressed ,
        icon: Icon(icon ,
          size: 28,),
      ),
    );
  }
}
