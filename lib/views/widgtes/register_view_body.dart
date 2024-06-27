
import 'package:ak_notes_app/controllers/auth_controller.dart';
import 'package:ak_notes_app/services/auth_service.dart';
import 'package:ak_notes_app/views/login_view.dart';
import 'package:ak_notes_app/views/notes_view.dart';
import 'package:ak_notes_app/views/verfication_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  DateTime? _selectedDate;
  bool passVisibility=true;
  String? userName , email , password , fName , lName , gender , age;
  final GlobalKey<FormState> _frmKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _authController = Provider.of<AuthController>(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
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
                                  return  '* required';
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
                                label: const Text("first name"),
                                border:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)
                                ) ,
                                // enabledBorder: fieldBorder(),
                                //focusedBorder: fieldBorder( kPrimaryColor),
                                hintText: "Enter Your username",
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
                                  return '* required';
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
                                label: const Text("last name"),
                                border:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)
                                ) ,
                                // enabledBorder: fieldBorder(),
                                //focusedBorder: fieldBorder( kPrimaryColor),
                                hintText: "Enter Your username",
                                // border:fieldBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16,),
                      Row(
                        children: [
                          SizedBox(
                            width: (MediaQuery.of(context).size.width/2)-48,
                            child: DropdownButton<DateTime>(
                              value: _selectedDate,
                              hint: const Text('Select a date'),
                              onTap:  _showDatePicker,
                              onChanged: (DateTime? newValue) {
                                // No-op, the date is selected via the date picker
                                _selectedDate.toString();
                              },
                              items: [
                                if (_selectedDate != null)
                                  DropdownMenuItem(
                                    value: _selectedDate,
                                    child: Text("${_selectedDate!.year}/${_selectedDate!.month}/${_selectedDate!.day}"),
                                  )
                                else
                                  const DropdownMenuItem(
                                    value: null,
                                    child: Text('Select a date'),
                                  ),
                              ],


                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width/2)-48,
                            child: DropdownButtonFormField(
                              validator: (value){
                                if(value?.isEmpty ?? true)
                                {
                                  return  '* required';
                                }
                                else{
                                  return null;
                                }
                              },
                              items: const [
                                DropdownMenuItem(value: "Male",child:  Text("Male") ) ,
                                 DropdownMenuItem(value: "Female",child: Text("Female") ),
                              ],
                              hint: const Text("Gender"),
                              onChanged: (value){
                                gender=value;
                              },
                              decoration:  InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)
                                 
                                )
                              )
                            ),
                          )],
                      ),
                      const SizedBox(height: 16,),
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
                          print(_selectedDate!.year);
                          _authController.createUserWithEmailAndPassword(
                            displayName: userName ,
                             fName: fName! ,
                             lName: lName! ,
                             gender: gender! ,
                             age:  "${_selectedDate!.year}/${_selectedDate!.month}/${_selectedDate!.day}",
                             email: email! ,
                             password: password!
                            )
                              .then((value){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const VerficationView()));
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
                                  child: const Text("Cancel")
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
                                child:  CircularProgressIndicator()): const Icon(Icons.app_registration) ,
                          const   SizedBox(width: 16,),
                            const Text("Register")
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
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginView()));

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
