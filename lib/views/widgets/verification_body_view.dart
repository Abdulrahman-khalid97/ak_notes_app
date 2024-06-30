
import 'dart:async';

import 'package:ak_notes_app/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../routes/routes.dart';
class VerificationBodyView extends StatefulWidget {
  const VerificationBodyView({super.key});

  @override
  State<VerificationBodyView> createState() => _VerificationBodyViewState();
}

class _VerificationBodyViewState extends State<VerificationBodyView> {
  final _auth = AuthController();
  late Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.sendEmailVerificationEmail();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer){
      FirebaseAuth.instance.currentUser?.reload();
      if(FirebaseAuth.instance.currentUser!.emailVerified){
        _timer.cancel();
        Navigator.popAndPushNamed(context, RouteManager.homeView);
         }
    });
  }
  @override
  Widget build(BuildContext context) {
    return
         Container(
           alignment: Alignment.center,
           child: SingleChildScrollView(
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment : CrossAxisAlignment.center ,
              children: [
                Image.asset("assets/images/mail-box.png" ,
                height: 120,
                width: 120,),
                const SizedBox(height: 32,),
                const Text("Verify Your Email Address" ,
                style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),) ,
               const  SizedBox(height: 24,),
               const  Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 24),
                  child:  Text("We've sent a verification email\nPlease check your inbox and click the link in the email to confirm your email address and finish setting up your account. Once you've verified your email, you'll be able to access all the features of the app." ,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,),
                )
                ,
               const  SizedBox(height:48,),
                TextButton(onPressed: () async{
                  await _auth.sendEmailVerificationEmail();

                }, child: const Text("Resend Email"))
              ],
                 ),
           ),
         );
  }
}
