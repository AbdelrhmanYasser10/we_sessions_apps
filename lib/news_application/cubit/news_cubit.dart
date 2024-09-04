import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:we_session1/news_application/model/news_model.dart';
import 'package:we_session1/news_application/shared/network/dio_helper.dart';

import '../shared/constants/constants.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  static NewsCubit get(context)=>BlocProvider.of(context);
  
  late NewsModel results;
   NewsModel? sliderNews;
   NewsModel? topHeadlines;
  
  void getResults({required String categoryName})async{
    emit(GetResultsLoading());
    try {
      Response response = await DioHelper.getRequest(
          endPoint: "top-headlines",
          queryParameters: {
            "country": "us",
            "category": categoryName,
            "apiKey": APIKEY,
          });
      print(response.data);
      results = NewsModel.fromJson(response.data);
      emit(GetResultsSuccess());
    }catch(error){
      print(error.toString());
      emit(GetResultsError());
    }
  }


  void getSliderNews()async{
    emit(GetSliderNewsLoading());
    try {
      Response r = await DioHelper.getRequest(
        endPoint: "top-headlines",
        queryParameters: {
          "country": "us",
          "apiKey": APIKEY,
        },
      );
      sliderNews = NewsModel.fromJson(r.data);
      emit(GetSliderNewsSuccess());
    }catch(error){
      emit(GetSliderNewsError());
    }
  }

  void getTopHeadlines()async{
    emit(GetBreakingNewsLoading());
    try {
      Response r = await DioHelper.getRequest(
          endPoint: "top-headlines",
          queryParameters: {
            "apiKey": APIKEY,
            "country": "us",
          }
      );
      topHeadlines = NewsModel.fromJson(r.data);
      emit(GetBreakingNewsSuccess());
    }catch(error){
      emit(GetBreakingNewsError());
    }
  }
}
