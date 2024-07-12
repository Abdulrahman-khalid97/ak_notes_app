
import 'package:ak_notes_app/app_local.dart';
import 'package:ak_notes_app/features/auth/presentation/provider/authentication_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/dialogs/snack_bar_dialoge.dart';
import '../../../../core/error/error_message_filter.dart';
import '../../../../core/style/text_style.dart';
class UpdatePasswordPageBody extends StatefulWidget {
  const UpdatePasswordPageBody({super.key});

  @override
  State<UpdatePasswordPageBody> createState() => _UpdatePasswordPageBodyState();
}

class _UpdatePasswordPageBodyState extends State<UpdatePasswordPageBody> {
  String? oldPassword , newPassword;
  bool oldPassVisibility=true , newPassVisibility=true , loading= false;
  final GlobalKey<FormState> _frmKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    // final userController = Provider.of<UserController>(context , listen:  true);
    AppLocal.init(context);
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
                  child: Text("${AppLocal.loc.update} ${AppLocal.loc.password}", style: kTitle1Style),
                ),
               const SizedBox(height: 50,),
                TextFormField(
                  validator: (value){
                    String errorMessage = '';

                    // Password length greater than 6
                    if (value!.length < 6) {
                      errorMessage=AppLocal.loc.required;
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
                    label:  Text(AppLocal.loc.oldPassword),
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
                    hintText: AppLocal.loc.oldPassword,

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
                        '${AppLocal.loc.passwordLonger}\n';
                      }
                      // Contains at least one uppercase letter
                      if (!value.contains(RegExp(r'[A-Z]'))) {
                        errorMessage +=
                        '${AppLocal.loc.upperCaseMissing}\n';
                      }
                      // Contains at least one lowercase letter
                      if (!value.toString().contains(RegExp(r'[a-z]'))) {
                        errorMessage +=
                        '${AppLocal.loc.lowerCaseMissing}\n';
                      }
                      // Contains at least one digit
                      if (!value.contains(RegExp(r'[0-9]'))) {
                        errorMessage += '${AppLocal.loc.digitMissing}\n';
                      }
                      // Contains at least one special character
                      if (!value.contains(
                          RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
                        errorMessage +=
                        '${AppLocal.loc.specialCharacter}\n';
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
                    label:  Text(AppLocal.loc.newPassword),
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
                    hintText: AppLocal.loc.newPassword,

                  ),
                ),
                const SizedBox(height: 24,),
                ElevatedButton(onPressed: (){
                  if(_frmKey.currentState!.validate()){
                    setState(() {
                      loading=true;
                    });
                  _frmKey.currentState!.save();
                  context.read<AuthenticationProvider>().updatePassword(oldPassword!, newPassword!).then((onValue){
                    setState(() {
                      loading=true;
                    });
                    SnackBarDialoge.showSnackBar(context , message: AppLocal.loc.updatedSuccessfully ,
                        bgColor: Colors.greenAccent, messageColor: Colors.black ,icon: Icons.check);
                    Navigator.of(context).pop();
                  }).catchError((onError){
                    setState(() {
                      loading=true;
                    });
                    SnackBarDialoge.showSnackBar(context , message: errorMessage(onError) ,
                        bgColor: Colors.red, messageColor: kWhiteColor ,icon: Icons.error_outline);
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
                       Text(AppLocal.loc.update)
                    ],
                  ),
                )),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pop(false);
                }, child:  SizedBox(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   const Icon(Icons.arrow_back),
                       const SizedBox(width: 16,),
                    Text(AppLocal.loc.cancel),
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
