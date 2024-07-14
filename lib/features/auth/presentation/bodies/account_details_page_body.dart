
import 'dart:typed_data';

import 'package:ak_notes_app/app_local.dart';
import 'package:ak_notes_app/core/provider_setting.dart';
import 'package:ak_notes_app/core/style/text_style.dart';
import 'package:ak_notes_app/core/utils.dart';
import 'package:ak_notes_app/features/auth/presentation/provider/authentication_provider.dart';
import 'package:ak_notes_app/features/auth/presentation/provider/storage_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../notes/presentation/widgets/custom_app_bar.dart';

class AccountDetailsPageBody extends StatefulWidget {
  const AccountDetailsPageBody({super.key});

  @override
  State<AccountDetailsPageBody> createState() => _AccountDetailsPageBodyState();
}

class _AccountDetailsPageBodyState extends State<AccountDetailsPageBody> {


  @override
  Widget build(BuildContext context) {
    AppLocal.init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24) ,
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          CustomAppBarBack(title: AppLocal.loc.settings),
          const SizedBox(
            height: 24,
          ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Center(
                child: Stack(
                  children: [
                    context.read<StorageProvider>().img != null?
                    CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage( context.watch<StorageProvider>().img!),
                    ): const CircleAvatar(
                      radius: 64,
                    ),
                    Positioned(
                        bottom: -5,
                        right: -0,
                        child: IconButton(icon: const Icon(Icons.image , size: 28,), onPressed: () async{
                          Map<Permission , PermissionStatus> status =await [Permission.storage , Permission.camera].request();
                          if(status[Permission.storage]!.isGranted && status[Permission.camera]!.isGranted ){
                            //await selectSource();
                        // context.read<StorageProvider>().selectImage();

                          }
                          //  selectImage();
                        },))
                  ],
                ),
              ),
              SizedBox(height: 16,),
              LinearProgressIndicator(value:context.watch<StorageProvider>().uploadProgress,semanticsLabel:context.watch<StorageProvider>().uploadProgress.toString() ,),
              Text(   context.watch<StorageProvider>().uploadProgress.toString()),
              context.read<StorageProvider>().img!=null?
              ElevatedButton(onPressed: ()async {
               // await selectSource();
                if(  context.read<StorageProvider>().img!=null){
                  await context.read<StorageProvider>().uploadImageProfile();
                  await context.read<AuthenticationProvider>().updateProfileImage(context.read<StorageProvider>().imageUrl!);

                }
              }
                  , child: Text("Save")) :
              SizedBox(),
            ],),
          )
        ],
      ),
    );
  }


}
