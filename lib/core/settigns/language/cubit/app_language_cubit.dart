import 'package:eks/core/network/local/remote/cache_helper.dart';
import 'package:eks/core/settigns/language/cubit/language_event_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'app_language_state.dart';


class AppLanguageCubit extends Cubit<AppLanguageState>{
  AppLanguageCubit() : super(AppLanguageInitial());

  appLanguageFunc(LanguageEventEnums eventType){
    switch(eventType){
      case LanguageEventEnums.InitailLanguage:
        if(CacheHelper.getData(key: 'lang')!=null){
          if(CacheHelper.getData(key: 'lang')=='ar'){
            emit(AppChangeLanguage(languageCode:'ar'));
          }
          else{emit(AppChangeLanguage(languageCode:'en'));}
        }
        break;
      case LanguageEventEnums.ArabicLangeuage:
        CacheHelper.saveData(key: 'lang', value: 'ar');
        emit(AppChangeLanguage(languageCode:'ar'));
        break;
      case LanguageEventEnums.EnglishLanguage:
        CacheHelper.saveData(key: 'lang', value: 'en');
        emit(AppChangeLanguage(languageCode:'en'));
        break;
    }
  }
}