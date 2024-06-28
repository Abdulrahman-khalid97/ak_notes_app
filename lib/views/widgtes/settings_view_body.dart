
import 'package:ak_notes_app/controllers/app_state.dart';
import 'package:ak_notes_app/controllers/user_controller.dart';
import 'package:ak_notes_app/models/user_model.dart';
import 'package:ak_notes_app/views/constants/enum/theme_enum.dart';
import 'package:ak_notes_app/views/widgtes/change_password_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


import 'custom_app_bar.dart';
class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {


  UserModel user= UserModel.empty();
  String? gender , fName , lName ;
  String? age;
  //bool loading=false;
  //List<bool> changed=[false , false , false , false];
  final GlobalKey<FormState> _frmKey = GlobalKey();
  final GlobalKey<FormState> _updateFrmKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  int? _selectedOption=-1;
  DateTime? _selectedDate;
  ThemeEnum? _themeEnumData;
  DateFormat formatter = DateFormat('yyyy/MM/dd');
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
   user.email= FirebaseAuth.instance.currentUser!.email.toString();
   user.id =FirebaseAuth.instance.currentUser!.uid.toString();
   user.userName= FirebaseAuth.instance.currentUser!.displayName!;

  }






  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserController>(context, listen: true);
    final appState = Provider.of<AppState>(context , listen: true);

    return
      ChangeNotifierProvider(
        create: (context)=>userProvider,

        child: Column(
          children:  [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomAppBar(tille: "Settings",icon: Icons.arrow_right_alt_outlined , onIconPressed: (){
                Navigator.pop(context);
              },),
            ) ,
            const SizedBox(
              height: 24,
            ),
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 64,
                  ),
                  Positioned(
                  bottom: -4,
                  right: -8,
                    child: IconButton(
                      icon: const Icon(Icons.add_photo_alternate_rounded , size: 32,) ,
                      onPressed: (){
                      },
                    ) ,)
                ],
              ),
            ) ,
            const SizedBox(
              height: 24,
            ),
            Text(FirebaseAuth.instance.currentUser!.displayName.toString()),
            const SizedBox(
              height: 24,
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Form(
                  key: _frmKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16 , horizontal: 24),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start ,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text("First Name", style: TextStyle(fontWeight: FontWeight.bold )),

                                  Selector<UserController , UserModel>(builder: (ctx , value ,child) {


                                        if (value.fName == null) {
                                          return SizedBox(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width / 3,
                                              child: const Text("Downloading..."));
                                        }
                                        else {
                                          fName = value.fName;
                                          user.fName = fName;
                                          return SizedBox(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width / 3,
                                            child:
                                            TextFormField(
                                              initialValue: value.fName,
                                              textAlign: TextAlign.center,
                                              validator: (value) {
                                                if (value?.isEmpty ?? true) {
                                                  return '* required';
                                                }
                                                else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (value) {
                                                if (user.fName != value) {
                                                userProvider.changeVal(0 , true);
                                                  fName = value;
                                                } else {
                                                  userProvider.changeVal(0 , false);
                                                  fName = user.fName;
                                                }
                                              },
                                              onSaved: (value) {
                                                fName = value;
                                              },
                                            ),
                                          );

                                      }
                                  },
                                  selector: (ctx , firebase){
                                   return firebase.user!;
                                  })
                                   ],
                              ),
                            ),
                          ),
                          Expanded(
                            child:  Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start ,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text("Last Name", style: TextStyle(fontWeight: FontWeight.bold),),
                                    Selector<UserController , UserModel>(builder: (ctx , value ,child){

                                      if(value.lName==null){
                                        return  SizedBox(
                                            width: MediaQuery.of(context).size.width / 3,
                                            child:const Text("Downloading..."));
                                      }
                                      else {
                                        lName=value.lName;
                                        user.lName=lName;
                                        return
                                          SizedBox(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width / 3,
                                            child: TextFormField(
                                              initialValue: value.lName,
                                              textAlign: TextAlign.center,
                                              validator: (value) {
                                                if (value?.isEmpty ?? true) {
                                                  return '* required';
                                                }
                                                else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (value) {
                                                if (lName != value) {
                                                  userProvider.changeVal(1, true);
                                                  lName = value;

                                                }
                                                else {
                                                  userProvider.changeVal(1 , false);
                                                  lName=value;
                                                }
                                              },
                                              onSaved: (value){
                                                lName=value;
                                              },
                                            ),
                                          );
                                      }
                                      //   Text(value , style: TextStyle(
                                      //     color: ThemeData.dark().primaryColorLight
                                      // ),);

                                    },
                                        selector: (ctx , firebase){
                                         // user.fetchUserData(FirebaseAuth.instance.currentUser!.uid);
                                          return firebase.user!;
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ) ,
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16 , horizontal: 24),
                              child: SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start ,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Gender", style: TextStyle(fontWeight: FontWeight.bold)),
                                    Selector<UserController , UserModel>(builder: (ctx , value ,child){

                                      if(value.gender==null){
                                        return  SizedBox(
                                            width: MediaQuery.of(context).size.width / 3,
                                            child:const Text("Downloading..."));
                                      }
                                      else {

                                        gender=value.gender;
                                        user.gender=value.gender;
                                        return SizedBox(

                                          width: (MediaQuery
                                              .of(context)
                                              .size
                                              .width / 2) - 48,
                                          child: DropdownButtonFormField(
                                            value: value.gender,
                                            validator: (value) {
                                              if (value?.isEmpty ?? true) {
                                                return '* required';
                                              }
                                              else {
                                                return null;
                                              }
                                            },
                                            onSaved: (value) {
                                              gender = value;
                                            },
                                            items: const [
                                              DropdownMenuItem(
                                                  value: "No Value",
                                                  child: Text("No Value")),
                                              DropdownMenuItem(value: "Male",
                                                  child: Text("Male")),
                                              DropdownMenuItem(
                                                  value: "Female",
                                                  child: Text("Female")),
                                            ],
                                            hint: const Text("Gender"),
                                            onChanged: (val) {
                                              if (val != gender) {
                                                userProvider.changeVal(2 , true);
                                                gender = val;
                                              } else {
                                                userProvider.changeVal(2 , false);
                                                gender=user.gender;
                                              }
                                            },

                                          ),
                                        );
                                      }

                                    },
                                        selector: (ctx , firebase){
                                          return firebase.user!;
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16 , horizontal: 24),
                              child: SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start ,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text("Age", style: TextStyle(fontWeight: FontWeight.bold),),
                                    Selector<UserController , String>(builder: (ctx , value ,child){




                                     if(value=="null"){
                                       user.age=0.toString();
                                       age="null";
                                       return  SizedBox(
                                           width: MediaQuery.of(context).size.width / 3,
                                           child:const Text("Downloading..."));
                                     }
                                     else {
                                       _selectedDate=formatter.parse(value);
                                        age =value;

                                       return SizedBox(
                                         width: MediaQuery
                                             .of(context)
                                             .size
                                             .width / 3,
                                         child:DropdownButton<String>(
                                           value: formatter.format(formatter.parse(value)),
                                           hint: const Text('Select a date'),
                                           onTap: ()  async{
                                            await  _showDatePicker();
                                            if(formatter.format(_selectedDate!) != formatter.format(formatter.parse(userProvider.user!.age!))) {

                                              userProvider.age=formatter.format(_selectedDate!);
                                              userProvider.changeVal(3 , true);

                                            }
                                            else{
                                              userProvider.changeVal(3 , false);
                                            }
                                           },
                                           onChanged: (String? newValue) {
                                             // No-op, the date is selected via the date picker
                                           },
                                           items: [

                                               DropdownMenuItem(
                                                 value: formatter.format(formatter.parse(value)),
                                                 child: Text(age.toString()),
                                               ),
                                             if(_selectedDate==null)
                                             const DropdownMenuItem(
                                               value: null,
                                               child: Text('Select a date'),
                                             ),

                                           ],

                                         ),
                                         // TextFormField(
                                         //   maxLength: 2,
                                         //
                                         //   keyboardType: TextInputType.number,
                                         //   initialValue: value == "null" ? 0
                                         //       .toString() : value,
                                         //   textAlign: TextAlign.center,
                                         //   validator: (value) {
                                         //     if (value?.isEmpty ?? true) {
                                         //       return '* required';
                                         //     }
                                         //     else {
                                         //       return null;
                                         //     }
                                         //   },
                                         //   onChanged: (value) {
                                         //     if (value != age) {
                                         //       changed[3] = true;
                                         //       age = int.parse(value);
                                         //     } else {
                                         //       changed[3] = false;
                                         //       age=int.parse(value);
                                         //     }
                                         //   },
                                         //   onSaved: (value){
                                         //     age=int.parse(value!);
                                         //   },
                                         // ),
                                       );
                                     }


                                    },
                                        selector: (ctx , firebase){
                                          // user.fetchUserData(FirebaseAuth.instance.currentUser!.uid);
                                          return firebase.user!.age.toString();
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ) ,
                      InkWell(
                        onTap: (){
                          _showAlertData(title:  "Email", userData: UserController().user!);

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16 , horizontal: 24),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Email" , style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(FirebaseAuth.instance.currentUser!.email.toString(), style: TextStyle(
                                    color: ThemeData.dark().primaryColorLight
                                ),)
                              ],
                            ),
                          ),
                        ),
                      ) ,
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChangePasswordBody()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16 , horizontal:24 ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               const Text("Password" , style: TextStyle(fontWeight: FontWeight.bold),),
                                Text("***********************", style: TextStyle(
                                    color: ThemeData.dark().primaryColorLight
                                ),)
                              ],
                            ),
                          ),
                        ),
                      ) ,
                      InkWell(onTap: (){
                        _selectedOption= appState.initialIsDarkMode?0:1;
                         _themeEnumData= _selectedOption==0?ThemeEnum.dark:ThemeEnum.light;
                        _showAlertTheme(onPressed: (){
                          appState.toggleTheme(_selectedOption==0?true: false);
                          // Do something with the selected option
                          Navigator.of(context).pop();
                        } , onLightChange:
                            (data){
                          setState((){
                            _themeEnumData=data!;
                            _selectedOption=1;
                          });
                        }, onDarkChange:  (data){
                          setState((){
                            _themeEnumData=data!;
                            _selectedOption=0;
                          });
                        },);
                       // appState.toggleTheme(!appState.initialIsDarkMode);
                      },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16 , horizontal: 24),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               const Text("Theme" , style:  TextStyle(fontWeight: FontWeight.bold),),
                                  Text(appState.initialIsDarkMode?"Dark":"Light", style: TextStyle(
                                            color: ThemeData.dark().primaryColorLight
                                        ),)
                              ],
                            ),
                          ),
                        ),
                      ) ,

                      const SizedBox(height: 50,),
                      (userProvider.changed[0] || userProvider.changed[1] || userProvider.changed[2]|| userProvider.changed[3])?
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/2,
                          child:   ElevatedButton(onPressed: ()async {
                            if(_frmKey.currentState!.validate()){

                              userProvider.loading=true;
                              _frmKey.currentState!.save();
                              userProvider.initialNewValue(fName!, lName!, gender!,
                                  "${_selectedDate!.year}/${_selectedDate!.month}/${_selectedDate!.day}");

                             await UserController().updateUser(user).then((onValue){
                               userProvider.changeVal(0 , false);
                               userProvider.changeVal(1, false);
                               userProvider.changeVal(2 , false);
                               userProvider.changeVal(3 , false);

                               userProvider.loading=false;

                              }).catchError((error){
                               userProvider.loading=false;
                                showDialog(context: context, builder: (context) => AlertDialog(
                                  icon: const Icon(Icons.error , size: 48,),
                                  title: const Text('Error'),
                                  content: Text(error.toString() , textAlign: TextAlign.center,),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(false),
                                      child: const Center(
                                      child:Text("Cancel")
                                      )
                                    ),
                                  ],
                                ),);

                              });

                            } else{

                              autoValidateMode= AutovalidateMode.always;

                            }
                          }, child:SizedBox(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                userProvider.loading?const SizedBox(
                                    width:24,
                                    height: 24,
                                    child:  CircularProgressIndicator()): const Icon(Icons.save) ,
                                const   SizedBox(width: 16,),
                                const Text("Save")
                              ],
                            ),
                          ))  ,

                        ),
                      ):const SizedBox()

                    ],
                  ),
                ),
              ),
            ) ,
          ],
        ),
      );
  }

  _showAlertTheme( {Function()? onPressed , required  Function(ThemeEnum?)? onDarkChange , required Function(ThemeEnum?)? onLightChange}){

    ThemeEnum themeEnumData= _selectedOption==0?ThemeEnum.dark:ThemeEnum.light;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            scrollable: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            title: const Text("Select Option"),
            content: StatefulBuilder(
              builder: (BuildContext context , void Function(void Function()) setState){
                return Column(
                  children: [
                    InkWell(
                      onTap: (){
                        setState((){
                          themeEnumData=ThemeEnum.dark;
                          _selectedOption=0;
                        });
                      },
                      child: Row(
                        children: [
                          Radio(
                            onChanged:onLightChange,
                            value: ThemeEnum.dark,
                            groupValue: themeEnumData,
                          ) ,
                          const Text("Dark")
                        ],
                      ),
                    ) ,
                    InkWell(
                      onTap: (){
                        setState((){
                          themeEnumData=ThemeEnum.light;
                          _selectedOption=1;
                        });
                      },
                      child: Row(
                        children: [
                          Radio(
                            onChanged:onDarkChange,
                            value: ThemeEnum.light,
                            groupValue: themeEnumData,
                          ) ,
                          const Text("Light")
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const  Text('Cancel'),
              ),
              ElevatedButton(
                onPressed:onPressed,
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  _showAlertData({required String title ,required UserModel userData}){
    showDialog(
      barrierDismissible: false,
        context: context, builder: (context)=>
    AlertDialog(
      title:   Text("Update $title"),
      content:Form(
        key: _updateFrmKey,
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: title=="First Name"?userData.fName
                : title=="Last Name"? userData.lName
                :title=="Email"?FirebaseAuth.instance.currentUser!.email.toString(): title=="Gender"?userData.gender
                :userData.age.toString(),
            keyboardType: title=="Age"? TextInputType.number:TextInputType.number,
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

            },
            autocorrect: true,

          )
        ],
      ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const  Text('Cancel'),
        ),
        ElevatedButton(
          onPressed:(){},
          child: const Text('OK'),
        ),
      ],
    ));
  }

  Future<void> _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );

    if (picked != null) {

      setState(() {
        _selectedDate = picked;
      });

    }
  }
}
