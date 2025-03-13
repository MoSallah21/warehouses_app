part of 'app_language_cubit.dart';

abstract class AppLanguageState{}

class AppLanguageInitial extends AppLanguageState{}

class AppChangeLanguage extends AppLanguageState{
  final String languageCode;

  AppChangeLanguage({required this.languageCode});
}