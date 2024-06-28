import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
   CustomTextField({super.key, required this.hint,  this.maxLines=1, this.onSaved,  this.textValue="", this.onChanged});
  final String hint;
  final int maxLines;
  final String textValue;
 final ScrollController _scrollController = ScrollController();
  final void Function(String?)? onSaved;
   final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return  
      maxLines==1?TextFormField(
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
      maxLines: maxLines!=1?null:maxLines,
      autocorrect: true,
      decoration: InputDecoration(
      // enabledBorder: fieldBorder(),
        //focusedBorder: fieldBorder( kPrimaryColor),
        hintText: hint,
       // border:fieldBorder(),
      ),
    ) : 
        Expanded(
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
            maxLines: maxLines!=1?null:maxLines,
            keyboardType: TextInputType.multiline,
            autocorrect: true,
            decoration: InputDecoration(
              // enabledBorder: fieldBorder(),
              isDense: true,
              //focusedBorder: fieldBorder( kPrimaryColor),
              hintText: hint,
              border:  maxLines==1? fieldBorder() :  InputBorder.none,
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
