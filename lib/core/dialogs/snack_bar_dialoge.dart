
import 'package:ak_notes_app/app_local.dart';
import 'package:ak_notes_app/core/style/color.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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

      padding: const EdgeInsets.only(left: 8 , right: 8 , top: 16 , bottom: 16),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(icon??Icons.info_outline) ,
              const SizedBox(width: 16,),
              Expanded(child: Text(message , style: TextStyle(color: messageColor),)) ,
            ],
          ),
        ),
    dismissDirection: DismissDirection.down,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


}

showSnackBarDeleted(context){
    final snackBar= SnackBar(

      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title:AppLocal.loc.note ,
        message: AppLocal.loc.deletedSuccessfully ,
        contentType: ContentType.warning,
        color:kPrimaryColor,

      ));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


