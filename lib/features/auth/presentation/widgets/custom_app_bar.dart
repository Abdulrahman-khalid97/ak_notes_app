import 'package:flutter/material.dart';

import '../../../../app_local.dart';
import '../../../../core/style/text_style.dart';

class CustomAppBar extends StatelessWidget {

  const CustomAppBar({super.key, required this.title});

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