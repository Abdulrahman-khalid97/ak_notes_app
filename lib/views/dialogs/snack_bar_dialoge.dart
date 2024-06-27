
import 'package:flutter/material.dart';

class SnackBarDialoge{
  static void showSnackBar(BuildContext context ,  {
    String message = "Have Added Successfully!",
    Color messageColor = Colors.white,
    Color bgColor = Colors.green,
    Color actionColor = Colors.green,
    String actionLabel = "DISMISS",
    IconData? icon
  }){
    final snackBar = SnackBar(
      padding: const EdgeInsets.only(left: 8 , right: 8 , top: 5 , bottom: 5),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(icon??Icons.info_outline) ,
            const SizedBox(width: 16,),
            Text(message , style: TextStyle(color: messageColor),) ,
            const Spacer() ,
            TextButton(onPressed: ()=> ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                child: const  Text('DISMISS' , style: TextStyle(
              fontWeight: FontWeight.bold
            ),))
          ],
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


}


