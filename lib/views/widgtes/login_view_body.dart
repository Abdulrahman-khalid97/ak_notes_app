
import 'package:ak_notes_app/services/auth_service.dart';
import 'package:ak_notes_app/views/notes_view.dart';
import 'package:ak_notes_app/views/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/animtion_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/firebase_controller.dart';
class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  String? errorMessage='';

  bool loading=false;
  // bool isLogin = true;
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
  //  final _firebaseController = Provider.of<FirebaseController>(context);
    return Scaffold(
      body: Container(
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
                                return 'This is Invalid Email';
                              }
                             else if(value?.isEmpty ?? true)
                              {
                                return 'Plz... fill field with value';
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
                              label: const Text("Email"),
                              border:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)
                              ) ,
                              // enabledBorder: fieldBorder(),
                              //focusedBorder: fieldBorder( kPrimaryColor),
                              hintText: "Enter Your Email",
                              // border:fieldBorder(),
                            ),
                          ),
                          const SizedBox(height: 16,),
                          TextFormField(
                            validator: (value){

                               if(value?.isEmpty ?? true)
                              {
                                return 'Plz... fill field with value';
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
                              label: const Text("Password"),
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
                              hintText: "Enter Your Password",

                            ),
                          ) ,
                          const SizedBox(height: 16,),
                          ElevatedButton(onPressed: (){
                            if(_frmKey.currentState!.validate()){
                              _frmKey.currentState!.save();
                              setState(() {
                                loading=true;
                              });
                              AuthService().signInWithEmailAndPassword(email: email!,password:  password!).then((value){
                               setState(() {
                                 loading=false;
                               });
                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NoteView()));
                              }).catchError((error){
                                setState(() {
                                  loading=false;
                                });

                                showDialog(context: context, builder: (context) => AlertDialog(
                                  icon: const Icon(Icons.error , size: 48,),
                                  title: const Text('Error'),
                                  content: Text(error.toString() , textAlign: TextAlign.center,),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(false),
                                      child: const  Text('Cancel'),
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
                                loading? const SizedBox(
                                   width:24,
                                    height: 24,
                                    child:  CircularProgressIndicator()): const Icon(Icons.login) ,
                                const SizedBox(width: 24,),
                              const  Text("Login")
                              ],
                            ),
                          )) ,
                          const  SizedBox(height: 16,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Haven't an account ? ") ,
                              InkWell(
                                onTap: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const RegisterView()));

                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterView()));
                                },
                                child: const Text("Create an account" ,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline ,
                                      decorationColor: Colors.blue
                                  ),),
                              )
                            ],)
                        ],
                      )),
                ),
              ],
            ),

      ),
    );
  }
}
