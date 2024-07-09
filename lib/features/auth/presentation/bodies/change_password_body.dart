//
// import 'package:ak_notes_app/app_local.dart';
// import 'package:ak_notes_app/controllers/user_controller.dart';
// import 'package:ak_notes_app/views/constants/font_style.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../core/style/text_style.dart';
// class ChangePasswordBody extends StatefulWidget {
//   const ChangePasswordBody({super.key});
//
//   @override
//   State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
// }
//
// class _ChangePasswordBodyState extends State<ChangePasswordBody> {
//   String? oldPassword , newPassword;
//   bool oldPassVisibility=true , newPassVisibility=true , loading= false;
//   final GlobalKey<FormState> _frmKey = GlobalKey();
//   AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
//
//   @override
//   Widget build(BuildContext context) {
//     // final userController = Provider.of<UserController>(context , listen:  true);
//     AppLocal.init(context);
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: Form(
//           key: _frmKey,
//           child: Center(
//             child: ListView(
//               shrinkWrap: true,
//               children: [
//                 Center(
//                   child: Text("${AppLocal.loc.update} ${AppLocal.loc.password}", style: kTitle1Style),
//                 ),
//                const SizedBox(height: 50,),
//                 TextFormField(
//                   validator: (value){
//                     String errorMessage = '';
//
//
//
//                     // Password length greater than 6
//                     if (value!.length < 6) {
//                       errorMessage=AppLocal.loc.required;
//                     }
//                     if(errorMessage==''){
//                       return null;
//                     }
//
//                     else{
//                       return errorMessage;
//                     }
//
//                   },
//                   onSaved: (value){
//                     oldPassword=value;
//                   },
//                   autocorrect: true,
//                   obscureText: oldPassVisibility,
//                   decoration: InputDecoration(
//                     label:  Text(AppLocal.loc.oldPassword),
//                     suffixIcon: IconButton(
//                       onPressed: (){
//                         setState(() {
//                           oldPassVisibility=!oldPassVisibility;
//                         });
//                       },
//                       icon: Icon(oldPassVisibility ? Icons.visibility : Icons.visibility_off),
//                     ),
//                     border:  OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8)
//                     ) ,
//                     hintText: AppLocal.loc.oldPassword,
//
//                   ),
//                 ),
//                 const SizedBox(height: 24,),
//                 TextFormField(
//                   validator: (value){
//                     String errorMessage = '';
//                     if((value?.isNotEmpty ?? true) || (value?.isEmpty ?? true) ) {
//
//                       // Password length greater than 6
//                       if (value!.length < 6) {
//                         errorMessage +=
//                         '${AppLocal.loc.passwordLonger}\n';
//                       }
//                       // Contains at least one uppercase letter
//                       if (!value.contains(RegExp(r'[A-Z]'))) {
//                         errorMessage +=
//                         '${AppLocal.loc.upperCaseMissing}\n';
//                       }
//                       // Contains at least one lowercase letter
//                       if (!value.toString().contains(RegExp(r'[a-z]'))) {
//                         errorMessage +=
//                         '${AppLocal.loc.lowerCaseMissing}\n';
//                       }
//                       // Contains at least one digit
//                       if (!value.contains(RegExp(r'[0-9]'))) {
//                         errorMessage += '${AppLocal.loc.digitMissing}\n';
//                       }
//                       // Contains at least one special character
//                       if (!value.contains(
//                           RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
//                         errorMessage +=
//                         '${AppLocal.loc.specialCharacter}\n';
//                       }
//                     }
//                     if(errorMessage==''){
//                       return null;
//                     }
//                     else{
//                       return errorMessage;
//                     }
//
//
//                   },
//                   onSaved: (value){
//                     newPassword=value;
//                   },
//                   autocorrect: true,
//                   obscureText: newPassVisibility,
//                   decoration: InputDecoration(
//                     label:  Text(AppLocal.loc.newPassword),
//                     suffixIcon: IconButton(
//                       onPressed: (){
//                         setState(() {
//                           newPassVisibility=!newPassVisibility;
//                         });
//                       },
//                       icon: Icon(newPassVisibility ? Icons.visibility : Icons.visibility_off),
//                     ),
//                     border:  OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8)
//                     ) ,
//                     hintText: AppLocal.loc.newPassword,
//
//                   ),
//                 ),
//                 const SizedBox(height: 24,),
//                 ElevatedButton(onPressed: (){
//                   if(_frmKey.currentState!.validate()){
//                     setState(() {
//                       loading=true;
//                     });
//                   _frmKey.currentState!.save();
//                     userController.updatePassword(oldPassword!, newPassword!).then((value){
//                        setState(() {
//                          loading=false;
//                        });
//                        print(AppLocal.loc.updatedSuccessfully);
//                      }).catchError((error){
//                        print("Error "+error.toString());
//                      });
//                   }
//                   else{
//                     autoValidateMode= AutovalidateMode.always;
//                   }
//
//                 }, child: SizedBox(
//                   width: 120,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       loading?const SizedBox(
//                           width:24,
//                           height: 24,
//                           child:  CircularProgressIndicator()): const Icon(Icons.password) ,
//                       const   SizedBox(width: 16,),
//                        Text(AppLocal.loc.update)
//                     ],
//                   ),
//                 )),
//                 ElevatedButton(onPressed: (){
//                   Navigator.of(context).pop(false);
//                 }, child:  SizedBox(
//                   child:  Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                    const Icon(Icons.arrow_back),
//                        const SizedBox(width: 16,),
//                     Text(AppLocal.loc.cancel),
//                   ],
//                 )))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
