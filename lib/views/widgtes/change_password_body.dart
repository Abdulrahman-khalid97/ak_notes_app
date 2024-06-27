

import 'package:ak_notes_app/controllers/auth_controller.dart';
import 'package:ak_notes_app/controllers/firebase_controller.dart';
import 'package:ak_notes_app/controllers/user_controller.dart';
import 'package:ak_notes_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  String? oldPassword , newPassword;
  bool oldPassVisibility=true , newPassVisibility=true , loading= false;
  final GlobalKey<FormState> _frmKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context , listen:  true);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _frmKey,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Text("Update Password" , style: TextStyle(
                      fontSize: 32 ,
                      fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(height: 50,),
                TextFormField(
                  validator: (value){
                    String errorMessage = '';
            
            
            
                    // Password length greater than 6
                    if (value!.length < 6) {
                      errorMessage='* Required';
                    }
                    if(errorMessage==''){
                      return null;
                    }
            
                    else{
                      return errorMessage;
                    }
            
                  },
                  onSaved: (value){
                    oldPassword=value;
                  },
                  autocorrect: true,
                  obscureText: oldPassVisibility,
                  decoration: InputDecoration(
                    label: const Text("Old Password"),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          oldPassVisibility=!oldPassVisibility;
                        });
                      },
                      icon: Icon(oldPassVisibility ? Icons.visibility : Icons.visibility_off),
                    ),
                    border:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)
                    ) ,
                    hintText: "Enter Your Old password",
            
                  ),
                ),
                const SizedBox(height: 24,),
                TextFormField(
                  validator: (value){
                    String errorMessage = '';
                    if((value?.isNotEmpty ?? true) || (value?.isEmpty ?? true) ) {
            
                      // Password length greater than 6
                      if (value!.length < 6) {
                        errorMessage +=
                        'Password must be longer than 6 characters.\n';
                      }
                      // Contains at least one uppercase letter
                      if (!value.contains(RegExp(r'[A-Z]'))) {
                        errorMessage +=
                        '• Uppercase letter is missing.\n';
                      }
                      // Contains at least one lowercase letter
                      if (!value.toString().contains(RegExp(r'[a-z]'))) {
                        errorMessage +=
                        '• Lowercase letter is missing.\n';
                      }
                      // Contains at least one digit
                      if (!value.contains(RegExp(r'[0-9]'))) {
                        errorMessage += '• Digit is missing.\n';
                      }
                      // Contains at least one special character
                      if (!value.contains(
                          RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
                        errorMessage +=
                        '• Special character is missing.\n';
                      }
                    }
                    if(errorMessage==''){
                      return null;
                    }
                    else{
                      return errorMessage;
                    }
            
            
                  },
                  onSaved: (value){
                    newPassword=value;
                  },
                  autocorrect: true,
                  obscureText: newPassVisibility,
                  decoration: InputDecoration(
                    label: const Text("New Password"),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          newPassVisibility=!newPassVisibility;
                        });
                      },
                      icon: Icon(newPassVisibility ? Icons.visibility : Icons.visibility_off),
                    ),
                    border:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)
                    ) ,
                    hintText: "Enter Your New password",
            
                  ),
                ),
                const SizedBox(height: 24,),
                ElevatedButton(onPressed: (){
                  if(_frmKey.currentState!.validate()){
                    setState(() {
                      loading=true;
                    });
                  _frmKey.currentState!.save();
                    userController.updatePassword(oldPassword!, newPassword!).then((value){
                       setState(() {
                         loading=false;
                       });
                       print("Done");
                     }).catchError((error){
                       print("Error "+error.toString());
                     });
                  }
                  else{
                    autoValidateMode= AutovalidateMode.always;
                  }

                }, child: SizedBox(
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      loading?const SizedBox(
                          width:24,
                          height: 24,
                          child:  CircularProgressIndicator()): const Icon(Icons.password) ,
                      const   SizedBox(width: 16,),
                      const Text("Update")
                    ],
                  ),
                )),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pop(false);
                }, child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back),
                    const   SizedBox(width: 16,),
                    Text("Back"),
                  ],
                )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
