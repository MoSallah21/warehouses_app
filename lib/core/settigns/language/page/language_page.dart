import 'package:eks/core/settigns/language/cubit/app_language_cubit.dart';
import 'package:eks/core/settigns/language/cubit/language_event_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSwitcherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Switcher'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'اختر اللغة:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AppLanguageCubit>(context).appLanguageFunc(
                        LanguageEventEnums.ArabicLangeuage);
                  },
                  child: Text('العربية'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AppLanguageCubit>(context).appLanguageFunc(
                        LanguageEventEnums.EnglishLanguage);                  },
                  child: Text('English'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
