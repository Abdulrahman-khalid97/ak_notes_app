
import 'package:ak_notes_app/app_local.dart';
import 'package:ak_notes_app/features/auth/domain/entities/user.dart';
import 'package:ak_notes_app/features/auth/presentation/provider/authentication_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/color.dart';
import '../../../../core/style/dimensional.dart';
import '../../../../routes/routes.dart';
import '../pages/login_page.dart';

class RegisterPageBody extends StatefulWidget {
  const RegisterPageBody({super.key});

  @override
  State<RegisterPageBody> createState() => _RegisterPageBodyState();
}

class _RegisterPageBodyState extends State<RegisterPageBody> {

  bool loading=false;
  DateTime? _selectedDate;
  bool passVisibility=true;
  String? userName , email , password , fName , lName ;
  final GlobalKey<FormState> _frmKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    AppLocal.init(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          padding:
          const EdgeInsets.symmetric(vertical: kVerticalBodyPadding),
          shrinkWrap: true,
          children: [
            const Image(
              image: AssetImage("assets/images/note_logo.png"),
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 32,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                  key: _frmKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: (MediaQuery.of(context).size.width/2)-48,
                            child: TextFormField(
                              validator: (value){
                                if(value?.isEmpty ?? true)
                                {
                                  return  AppLocal.loc.required;
                                }
                                else{
                                  return null;
                                }
                              },
                              onSaved: (value){
                                fName=value;
                              },
                              autocorrect: true,
                              decoration: InputDecoration(
                                label:  Text(AppLocal.loc.fname),
                                border:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)
                                ) ,
                                // enabledBorder: fieldBorder(),
                                //focusedBorder: fieldBorder( kPrimaryColor),
                                hintText: AppLocal.loc.fname,
                                // border:fieldBorder(),
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width/2)-48,
                            child: TextFormField(
                              validator: (value){
                                if(value?.isEmpty ?? true)
                                {
                                  return AppLocal.loc.required;
                                }
                                else{
                                  return null;
                                }
                              },
                              onSaved: (value){
                                lName=value;
                              },
                              autocorrect: true,
                              decoration: InputDecoration(
                                label: Text(AppLocal.loc.lname),
                                border:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)
                                ) ,
                                // enabledBorder: fieldBorder(),
                                //focusedBorder: fieldBorder( kPrimaryColor),
                                hintText: AppLocal.loc.lname,
                                // border:fieldBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16,),
                      TextFormField(
                        validator: (value){
                          if(value?.isEmpty ?? true)
                          {
                            return AppLocal.loc.inValidUserName;
                          }
                          else{
                            return null;
                          }
                        },
                        onSaved: (value){
                          userName=value;
                        },
                        autocorrect: true,
                        decoration: InputDecoration(
                          label:  Text(AppLocal.loc.userName),
                          border:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)
                          ) ,
                          // enabledBorder: fieldBorder(),
                          //focusedBorder: fieldBorder( kPrimaryColor),
                          hintText: AppLocal.loc.userName,
                          // border:fieldBorder(),
                        ),
                      ),
                      const SizedBox(height: 16,),
                      TextFormField(
                        validator: (value){
                          RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                          bool isValidEmail = emailRegex.hasMatch(value.toString());
                          if(!isValidEmail){
                            return AppLocal.loc.inValidEmail;
                          }
                          else
                          if(value?.isEmpty ?? true)
                          {
                            return AppLocal.loc.inValidEmail;
                          }
                          else{
                            return null;
                          }
                        },
                        onSaved: (value){
                          email=value;
                        },
                        autocorrect: true,
                        decoration: InputDecoration(
                          label:  Text(AppLocal.loc.email),
                          border:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)
                          ) ,
                          // enabledBorder: fieldBorder(),
                          //focusedBorder: fieldBorder( kPrimaryColor),
                          hintText: AppLocal.loc.email,
                          // border:fieldBorder(),
                        ),
                      ),
                      const SizedBox(height: 16,),
                      TextFormField(
                        validator: (value){
                          String errorMessage = '';
                          if((value?.isNotEmpty ?? true) || (value?.isEmpty ?? true) ) {

                            // Password length greater than 6
                            if (value!.length < 6) {
                              errorMessage +="${AppLocal.loc.passwordLonger}\n";
                            }
                            // Contains at least one uppercase letter
                            if (!value.contains(RegExp(r'[A-Z]'))) {
                              errorMessage +=
                              "• ${AppLocal.loc.upperCaseMissing}\n";
                            }
                            // Contains at least one lowercase letter
                            if (!value.toString().contains(RegExp(r'[a-z]'))) {
                              errorMessage +=
                              "• ${AppLocal.loc.lowerCaseMissing}\n";
                            }
                            // Contains at least one digit
                            if (!value.contains(RegExp(r'[0-9]'))) {
                              errorMessage +=  "• ${AppLocal.loc.digitMissing}\n";
                            }
                            // Contains at least one special character
                            if (!value.contains(
                                RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
                              errorMessage +=
                              "• ${AppLocal.loc.specialCharacter}\n";
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
                          password=value;
                        },
                        autocorrect: true,
                        obscureText: passVisibility,
                        decoration: InputDecoration(
                          label:  Text(AppLocal.loc.password),
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                passVisibility=!passVisibility;
                              });
                            },
                            icon: Icon(passVisibility ? Icons.visibility : Icons.visibility_off),
                          ),
                          border:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)
                          ) ,
                          hintText: AppLocal.loc.password,

                        ),
                      ) ,
                      const SizedBox(height: 16,),
                      ElevatedButton(onPressed: () async{
                        if(_frmKey.currentState!.validate()){
                          _frmKey.currentState!.save();
                          setState(() {
                            loading=true;
                          });
                         await context.read<AuthenticationProvider>().register(
                             UserEntity(displayName: userName ,
                                 firstName: fName! ,
                                 lastName: lName! ,
                                 password: password! ,
                                 imageUrl: "",
                                 email: email!,
                                 createdAt: Timestamp.fromDate(DateTime.now()) ,
                                 updatedAt: Timestamp.fromDate(DateTime.now())
                             )
                         )
                              .then((value){
                            Navigator.popAndPushNamed(context, RouteManager.verificationPage);
                          }).catchError((error){
                            print(error);
                            setState(() {
                              loading=false;
                            });
                            showDialog(context: context, builder: (context) => AlertDialog(
                              icon: const Icon(Icons.error , size: 48,),
                              title:  Text(AppLocal.loc.error),
                              content: Text(error.toString() , textAlign: TextAlign.center,),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child:  Text(AppLocal.loc.cancel)
                                ),
                              ],
                            ),);

                          });
                        }
                        else{
                          autoValidateMode= AutovalidateMode.always;

                        }

                      },
                          child: SizedBox(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                loading?const SizedBox(
                                    width:24,
                                    height: 24,
                                    child:  CircularProgressIndicator()): const Icon(Icons.app_registration, color:kWhiteColor,) ,
                                const   SizedBox(width: 16,),
                                Text(AppLocal.loc.register , style:const  TextStyle(color: kWhiteColor))
                              ],
                            ),
                          )) ,
                      const  SizedBox(height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocal.loc.already) ,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                Navigator.popAndPushNamed(context, RouteManager.loginPage);

                              },
                              child:  Text(AppLocal.loc.logIn ,
                                style: const  TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline ,
                                    decorationColor: Colors.blue
                                ),),
                            ),
                          )
                        ],)
                    ],
                  )

              ),
            )

          ],
        ),

      ),
    );
  }

  Future<void> _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),

    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });


    }
  }
}
