
import 'package:ak_notes_app/controllers/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'custom_app_bar.dart';
class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children:  [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: CustomAppBar(tille: "Settings",icon: Icons.arrow_right_alt_outlined , onIconPressed: (){
              Navigator.pop(context);
            },),
          ) ,
          SizedBox(
            height: 24,
          ),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 64,
                ),
                Positioned(child: IconButton(
                  icon:Icon(Icons.add_photo_alternate_rounded , size: 32,) ,
                  onPressed: (){
                  },
                ) ,
                bottom: -4,
                right: -8,)
              ],
            ),
          ) ,
          SizedBox(
            height: 24,
          ),
          Text(FirebaseAuth.instance.currentUser!.displayName.toString()),
          SizedBox(
            height: 24,
          ),
          ListView(
            shrinkWrap: true,
            children:  [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start ,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("First Name", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Abdulrahman Khalid" , style: TextStyle(
                          color: ThemeData.dark().primaryColorLight
                        ),)
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start ,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Last Name", style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("Abdulrahman Khalid", style: TextStyle(
                            color: ThemeData.dark().primaryColorLight
                        ),)
                      ],
                    ),
                  ),
                ],
              ) ,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email" , style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(FirebaseAuth.instance.currentUser!.email.toString(), style: TextStyle(
                        color: ThemeData.dark().primaryColorLight
                    ),)
                  ],
                ),
              ) ,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Password" , style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("***********************", style: TextStyle(
                        color: ThemeData.dark().primaryColorLight
                    ),)
                  ],
                ),
              ) ,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Theme" , style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("Dark", style: TextStyle(
                        color: ThemeData.dark().primaryColorLight
                    ),)
                  ],
                ),
              )
            ],
          )

        ],
      ),
    );
  }
}
