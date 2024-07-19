
import 'package:ak_notes_app/app_local.dart';
import 'package:ak_notes_app/core/style/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/error/error_message_filter.dart';
import '../../../../routes/routes.dart';
import '../provider/authentication_provider.dart';
class LoginPageBody extends StatefulWidget {
  const LoginPageBody({super.key});

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {


  bool passVisibility=true;
  String? email , password;
  final GlobalKey<FormState> _frmKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AppLocal.init(context);
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_)=>Provider.of<AuthenticationProvider>(context , listen: false),
        child: Container(
          alignment: Alignment.center,
          child:  ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shrinkWrap: true,
            children: [
              const  Center(child: Text("AK Notes" , style:
              TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 24
              )) , ),
              const  SizedBox(height: 16,),
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
                        TextFormField(
                          validator: (value){
                            RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                            bool isValidEmail = emailRegex.hasMatch(value.toString());
                            if(!isValidEmail){
                              return AppLocal.loc.inValidEmail;
                            }
                            else if(value?.isEmpty ?? true)
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
                            label: Text(AppLocal.loc.email),
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

                            if(value?.isEmpty ?? true)
                            {
                              return AppLocal.loc.required;
                            }
                            else{
                              return null;
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
                            await context.read<AuthenticationProvider>().login(email!, password!).then((value){

                              Navigator.popAndPushNamed(context, RouteManager.homePage);
                            }).catchError((error){
                              showDialog(context: context, builder: (context) => AlertDialog(
                                icon: const Icon(Icons.error , size: 48,),
                                title:  Text(AppLocal.loc.error),
                                content: Text(errorMessage(error)?? "", textAlign: TextAlign.center,),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child:   Text(AppLocal.loc.cancel),
                                  ),
                                ],
                              ),);

                            });
                          }
                          else{
                            autoValidateMode= AutovalidateMode.always;
                          }
                        }, child: Container(
                          alignment: Alignment.center,
                          width: 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Consumer<AuthenticationProvider>(
                                builder: (context, authProvider, child) {
                                  return Row(
                                    children: [
                                      if (authProvider.inProgressing)
                                        const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(),
                                        )
                                      else
                                        const Icon(Icons.login , color: Colors.white,),
                                      const SizedBox(width: 16),
                                      Text(AppLocal.loc.logIn , style:const  TextStyle(color: kWhiteColor),),
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        )) ,
                        const  SizedBox(height: 16,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppLocal.loc.haveNotAnAccount) ,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.popAndPushNamed(context, RouteManager.registerPage);

                                },
                                child:  Text(AppLocal.loc.createAnAccount ,
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline ,
                                      decorationColor: Colors.blue
                                  ),),
                              ),
                            )
                          ],)
                      ],
                    )),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
