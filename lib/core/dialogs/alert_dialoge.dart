
import 'package:ak_notes_app/app_local.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

showDeleteAlert(context){
  return QuickAlert.show(context: context, type: QuickAlertType.info , title: "${AppLocal.loc.delete} ${AppLocal.loc.note}" ,
      confirmBtnText:AppLocal.loc.delete ,
      cancelBtnText: AppLocal.loc.cancel ,
      showCancelBtn: true ,
      onConfirmBtnTap: ()=>Navigator.of(context).pop(true),
      onCancelBtnTap: ()=>Navigator.of(context).pop(false)
  );
}