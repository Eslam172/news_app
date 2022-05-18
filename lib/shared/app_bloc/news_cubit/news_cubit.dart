import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/business_screen.dart';
import 'package:news_app/screens/science_screen.dart';
import 'package:news_app/screens/sports_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'news_states.dart';





class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int selectedIndex =0;
  
  List<Widget> screens=[
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen()
  ];
  
  void changeBottomNav(int index){
    selectedIndex = index;

    if(index == 1){
      getSports();
    }else if(index == 2){
      getScience();
    }
    emit(NewsChangeBottomNavState());
  }

  List<dynamic> business=[];

  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          "country" : "eg",
          "category" : "business",
          "apiKey" : "2297313160604b1ab8f55178def10e9f",
        }
    ).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      emit(NewsGetBusinessErrorState());
      print(error.toString());
    });
  }

  List<dynamic> sports=[];

  void getSports(){
    emit(NewsGetSportsLoadingState());
    if(sports.isEmpty){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            "country" : "eg",
            "category" : "sports",
            "apiKey" : "2297313160604b1ab8f55178def10e9f",
          }
      ).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        emit(NewsGetSportsErrorState());
        print(error.toString());
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }

  }

  List<dynamic> science=[];

  void getScience(){
    emit(NewsGetScienceLoadingState());

    if(science.isEmpty){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            "country" : "eg",
            "category" : "science",
            "apiKey" : "2297313160604b1ab8f55178def10e9f",
          }
      ).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        emit(NewsGetScienceErrorState());
        print(error.toString());
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }

  }

  List<dynamic> search =[];

  void getSearch(String value){
    emit(NewsGetSearchLoadingState());
    search =[];

    DioHelper.getData(
        url: 'v2/everything',
        query: {
          "q" : value,
          "apiKey" : "2297313160604b1ab8f55178def10e9f",
        }
    ).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());

    }).catchError((error){
      emit(NewsGetSearchErrorState());

    });
  }
}