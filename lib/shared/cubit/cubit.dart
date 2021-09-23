import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  List<dynamic> everything = [];

  void getEverything() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
         'language':'en',
        'apiKey': 'cec85adb98c9466695edac5ea1cdf75f'
      },
    ).then((value) {
      everything = value.data['articles'];
      print('=====${everything.length}=====');
      emit(NewsGetEverythingSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetEverythingErrorState(error.toString()));
    });
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'language':'en',
        'category':'business',
        'apiKey': 'cec85adb98c9466695edac5ea1cdf75f'
      },
    ).then((value) {
      business = value.data['articles'];
      print('=====${business.length}=====');
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'language':'en',
        'category':'sports',
        'apiKey': 'cec85adb98c9466695edac5ea1cdf75f'
      },
    ).then((value) {
      sports = value.data['articles'];
      print('=====${sports.length}=====');
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'language':'en',
        'category':'science',
        'apiKey': 'cec85adb98c9466695edac5ea1cdf75f'
      },
    ).then((value) {
      science = value.data['articles'];
      print('=====${science.length}=====');
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apiKey': 'cec85adb98c9466695edac5ea1cdf75f'
      },
    ).then((value) {
      search = value.data['articles'];
      print('=====${search.length}=====');
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  bool isDark = true;

  void changeAppMode({bool fromShared}){
    if(fromShared != null){
      isDark = fromShared;
      emit(NewsChangeModeState());
    }
    else{
      isDark = !isDark;
      CacheHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeModeState());
      });
    }

  }

}
