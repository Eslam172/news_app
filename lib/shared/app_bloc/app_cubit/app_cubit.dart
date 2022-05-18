import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/app_bloc/app_cubit/app_states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({bool? fromShared}){
    if(fromShared != null){
      isDark =fromShared;
      emit(ChangeAppModeState());
    }else {
      isDark =!isDark;

      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeAppModeState());

      });
    }

  }
}