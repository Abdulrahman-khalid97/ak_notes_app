import 'package:flutter/material.dart';

class TitleTextFieldTextField extends StatelessWidget {
  TitleTextFieldTextField({super.key, required this.hint,  this.onSaved,  this.textValue="", this.onChanged});
  final String hint;
  final String textValue;
  final ScrollController _scrollController = ScrollController();
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: textValue,
      onSaved: onSaved,
      onChanged: onChanged,
      validator: (value){
        if(value?.isEmpty ?? true)
        {
          return 'Plz... fill field with value';
        }
        else{
          return null;
        }
      },
      maxLines:1,
      autocorrect: true,
      decoration: InputDecoration(
        // enabledBorder: fieldBorder(),
        //focusedBorder: fieldBorder( kPrimaryColor),
        hintText: hint,
        // border:fieldBorder(),
      ),
    );

  }

  OutlineInputBorder fieldBorder([color]){
    return OutlineInputBorder(
        borderSide:  BorderSide(
            color: color ?? Colors.white
        ),
        borderRadius: BorderRadius.circular(5)
    );
  }
}