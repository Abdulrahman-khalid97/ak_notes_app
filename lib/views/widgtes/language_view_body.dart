
import 'package:ak_notes_app/app_local.dart';
import 'package:ak_notes_app/setting_provider.dart';
import 'package:ak_notes_app/views/constants/font_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_app_bar.dart';

class LanguageViewBody extends StatefulWidget {
  const LanguageViewBody({super.key});

  @override
  State<LanguageViewBody> createState() => _LanguageViewBodyState();
}

class _LanguageViewBodyState extends State<LanguageViewBody> {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingProvider>(context , listen: true);
    AppLocal.init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
                 CustomAppBar(tille: AppLocal.loc.language,icon: Icons.arrow_right_alt_outlined , onIconPressed: (){Navigator.pop(context);}),

              const SizedBox(
                height: 24,
              ),
              Text(AppLocal.loc.languageViewTitle , style: kTitle1Style,textAlign: TextAlign.start,),
              Expanded(
                child: ListView(
                  children: [
                    RadioListTile(value: AppLocal.loc.langAR, groupValue:settings.local=='ar'?AppLocal.loc.langAR : AppLocal.loc.langEN , onChanged: (value){
                      settings.updateLocal(AppLocal.loc.ar);
                     } , title: Text(AppLocal.loc.langAR),) ,
                    RadioListTile(value: AppLocal.loc.langEN, groupValue:settings.local=='ar'?AppLocal.loc.langAR : AppLocal.loc.langEN , onChanged: (value){
                      settings.updateLocal(AppLocal.loc.en);
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
