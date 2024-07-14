
import 'package:ak_notes_app/app_local.dart';
import 'package:ak_notes_app/features/auth/presentation/widgets/custom_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/provider_setting.dart';
import '../../../../core/style/text_style.dart';


class LanguagePageBody extends StatefulWidget {
  const LanguagePageBody({super.key});

  @override
  State<LanguagePageBody> createState() => _LanguagePageBodyState();
}

class _LanguagePageBodyState extends State<LanguagePageBody> {
  @override
  Widget build(BuildContext context) {
    AppLocal.init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
                 CustomAppBar(title: AppLocal.loc.language),

              const SizedBox(
                height: 24,
              ),
              Text(AppLocal.loc.languageViewTitle , style: kTitleHeaderStyle,textAlign: TextAlign.start,),
              Expanded(
                child: ListView(
                  children: [
                    RadioListTile(value: AppLocal.loc.langAR, groupValue:context.read<SettingProvider>().local=='ar'?AppLocal.loc.langAR : AppLocal.loc.langEN , onChanged: (value){
                      context.read<SettingProvider>().updateLocal(AppLocal.loc.ar);
                     } , title: Text(AppLocal.loc.langAR),) ,
                    RadioListTile(value: AppLocal.loc.langEN, groupValue:context.read<SettingProvider>().local=='ar'?AppLocal.loc.langAR : AppLocal.loc.langEN , onChanged: (value){
                      context.read<SettingProvider>().updateLocal(AppLocal.loc.en);
                    } , title: Text(AppLocal.loc.langEN),)
                  ],
                ),
              )
            ],
        ),
      ),
    );
  }
}
