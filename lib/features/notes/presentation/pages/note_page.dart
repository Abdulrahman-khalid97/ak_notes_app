


import 'package:ak_notes_app/app_local.dart';
import 'package:ak_notes_app/core/style/dimensional.dart';
import 'package:ak_notes_app/features/auth/presentation/provider/authentication_provider.dart';
import 'package:ak_notes_app/features/notes/presentation/widgets/custom_app_bar.dart';
import 'package:ak_notes_app/features/notes/presentation/widgets/custom_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/dialogs/snack_bar_dialoge.dart';
import '../../../../core/error/error_message_filter.dart';
import '../../../../core/provider_setting.dart';
import '../../../../core/strings/color.dart';
import '../../../../routes/routes.dart';

import '../bodies/note_page_body.dart';

class NotesPage extends StatelessWidget {
   const  NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
AppLocal.init(context);


    return   SafeArea(
      child: Scaffold(
          body:   Padding(
            padding:   const EdgeInsets.symmetric(horizontal: kHorizontalBodyPadding),
            child: Column(
              children: [
                const  SizedBox(
                  height: kAppBarUp,
                ),
               _buildAppBar(context),
                const  SizedBox(
                  height: kAppBarBottom,
                ),
                const NotesPageBody(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(onPressed: (){
            Navigator.of(context).pushNamed(RouteManager.addNotePage);
          } ,

            shape: const CircleBorder(),
            child: const  Icon(Icons.add , color: kWhiteColor,),
          )
      ),
    );
  }

   Widget _buildAppBar(BuildContext context){
     final setting = Provider.of<SettingProvider>(context , listen: true);
    return  CustomAppBar(
      title: AppLocal.loc.theNotes,
      onIconPressed: (){
        showSearch(
            context: context, delegate: CustomSearchDelegate());
      },
      icon: Icons.search,
      onSelected: (item) async {
        switch(item){
          case 0 :
          Navigator.of(context).pushNamed(RouteManager.settingPage);
            break;
          case 1 :
            await context.read<AuthenticationProvider>().signOut().then((value){
              Navigator.popAndPushNamed(context, RouteManager.loginPage);
            }).catchError((error){
              print(error.runtimeType);
     SnackBarDialoge.showSnackBar(context , message: errorMessage(error) ,
     bgColor: Colors.red, messageColor: kWhiteColor ,icon: Icons.error_outline);
     });
            break;

        }
      },
    );
   }
}



