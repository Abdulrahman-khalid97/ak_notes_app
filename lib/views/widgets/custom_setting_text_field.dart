import 'package:ak_notes_app/app_local.dart';
import 'package:flutter/material.dart';

import '../constants/font_style.dart';
class CustomSettingTextField extends StatelessWidget {
  const CustomSettingTextField({super.key, required this.title,required this.preValue, required this.fieldValue, this.onChangedValue, this.onSavedValue});

  final String title , fieldValue , preValue;
  final void Function(String)? onChangedValue;
  final void Function(String?)? onSavedValue;
  @override
  Widget build(BuildContext context) {
    AppLocal.init(context);
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16 , horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start ,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: kTitle2Style),
             preValue==null?SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 3,
                child: Text(AppLocal.loc.downloading)):
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 3 ,
              child: TextFormField(
                initialValue: fieldValue,
                textAlign: TextAlign.center,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return AppLocal.loc.required;
                  }
                  else {
                    return null;
                  }
                } , onSaved: onSavedValue,
              ),
            ),

          ],
        ),
      );
  }
}
