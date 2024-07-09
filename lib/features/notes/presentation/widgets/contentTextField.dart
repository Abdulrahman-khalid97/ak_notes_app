import 'package:flutter/material.dart';

class ContentTextFied extends StatelessWidget {
  ContentTextFied({super.key, required this.hint,  this.onSaved,  this.textValue="", this.onChanged});
  final String hint;
  final String textValue;
  final ScrollController _scrollController = ScrollController();
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
          trackVisibility: false,
          controller: _scrollController,
          child: TextFormField(

            initialValue: textValue,
            scrollController: _scrollController,
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
            maxLines: null,
            keyboardType: TextInputType.multiline,
            autocorrect: true,
            decoration: InputDecoration(
              // enabledBorder: fieldBorder(),
              isDense: true,
              //focusedBorder: fieldBorder( kPrimaryColor),
              hintText: hint,
              border: InputBorder.none,
            ),
          )),
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