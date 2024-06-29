
import 'package:ak_notes_app/app_local.dart';
import 'package:flutter/material.dart';
class AlertDialoge{


  showAlertDialog(BuildContext context) {
    AppLocal.init(context);
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title:  Text("${AppLocal.loc.delete} ${AppLocal.loc.note}"),
        content:   Text(AppLocal.loc.deleteNoteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:  Text(AppLocal.loc.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocal.loc.delete),
          ),
        ],
      ),
    );
  }
}