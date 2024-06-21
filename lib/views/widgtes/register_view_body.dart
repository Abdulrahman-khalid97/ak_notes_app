
import 'package:ak_notes_app/controllers/auth_controller.dart';
import 'package:ak_notes_app/views/login_view.dart';
import 'package:ak_notes_app/views/notes_view.dart';
import 'package:ak_notes_app/views/verfication_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/firebase_controller.dart';
class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  String? errorMessage='';
  bool isLogin = true;
  bool loading=false;
  bool passVisibility=true;
  String? userName , email , password;
  final GlobalKey<FormState> _frmKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _firebaseController = Provider.of<FirebaseController>(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16),
          shrinkWrap: true,
          children: [
            Image(
              image: AssetImage("assets/images/note_logo.png"),
              width: 150,
              height: 150,
            ),
            SizedBox(height: 32,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                  key: _frmKey,
                  child: Column(
                    children: [

                      TextFormField(
                        validator: (value){
                          if(value?.isEmpty ?? true)
                          {
                            return 'Please... Enter Username';
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
                          label: const Text("username"),
                          border:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)
                          ) ,
                          // enabledBorder: fieldBorder(),
                          //focusedBorder: fieldBorder( kPrimaryColor),
                          hintText: "Enter Your username",
                          // border:fieldBorder(),
                        ),
                      ),
                      const SizedBox(height: 16,),
                      TextFormField(
                        validator: (value){
                          RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                          bool isValidEmail = emailRegex.hasMatch(value.toString());
                          if(!isValidEmail){
                            return 'This is Invalid Email';
                          }
                          else
                          if(value?.isEmpty ?? true)
                          {
                            return 'Please... Enter Email';
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
                          String errorMessage = '';
                          if((value?.isNotEmpty ?? true) || (value?.isEmpty ?? true) ) {

                            // Password length greater than 6
                            if (value!.length < 6) {
                              errorMessage +=
                              'Password must be longer than 6 characters.\n';
                            }
                            // Contains at least one uppercase letter
                            if (!value!.contains(RegExp(r'[A-Z]'))) {
                              errorMessage +=
                              '• Uppercase letter is missing.\n';
                            }
                            // Contains at least one lowercase letter
                            if (!value!.toString().contains(RegExp(r'[a-z]'))) {
                              errorMessage +=
                              '• Lowercase letter is missing.\n';
                            }
                            // Contains at least one digit
                            if (!value!.contains(RegExp(r'[0-9]'))) {
                              errorMessage += '• Digit is missing.\n';
                            }
                            // Contains at least one special character
                            if (!value!.contains(
                                RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
                              errorMessage +=
                              '• Special character is missing.\n';
                            }
                          }
                          if(errorMessage==''){
                            print("object");
                            return null;
                          }

                          else{
                            return errorMessage;
                          }
                          // // If there are no error messages, the password is valid
                          // if(value?.isEmpty ?? true)
                          // {
                          //    errorMessage= 'Please... Enter password';
                          // }
                          // else
                          //

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
                          _firebaseController.createUserWithEmailAndPassword(userName! , email! ,password!)
                              .then((value){
                                _firebaseController.sendEmailVerficationEmail();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VerficationView()));

                          }).catchError((error){
                            setState(() {
                              loading=false;
                            });
                            print(error.toString());
                            showDialog(context: context, builder: (context) => AlertDialog(
                              icon: const Icon(Icons.error , size: 48,),
                              title: const Text('Error'),
                              content: Text(error.toString() , textAlign: TextAlign.center,),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      loading?
                                       Container(
                                          width:24,
                                          height: 24,
                                          child: const CircularProgressIndicator())
                                          :const Icon(Icons.app_registration) ,
                                     const SizedBox(width: 24,),
                                     const Text("Register")
                                    ],
                                  ),
                                ),
                              ],
                            ),);

                          });
                        }
                        else{
                          autoValidateMode= AutovalidateMode.always;

                        }

                      }, child: Container(
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            loading?Container(
                                width:24,
                                height: 24,
                                child: CircularProgressIndicator()):Icon(Icons.app_registration) ,
                            SizedBox(width: 16,),
                            Text("Register")
                          ],
                        ),
                      )) ,
                      const  SizedBox(height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already, Have an account ? ") ,
                          InkWell(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginView()));

                            },
                            child: const Text("Login" ,
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline ,
                                  decorationColor: Colors.blue
                              ),),
                          )
                        ],)
                    ],
                  )),
            )

          ],
        ),

      ),
    );
  }
}
