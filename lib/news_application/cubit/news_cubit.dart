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
  
  void getResults({required String categoryName})async{
    emit(GetResultsLoading());
    try {
      Response response = await DioHelper.getRequest(
          endPoint: "top-headlines",
          queryParameters: {
            "country": "eg",
            "category": categoryName,
            "apiKey": APIKEY,
          });
      results = NewsModel.fromJson(response.data);
      emit(GetResultsSuccess());
    }catch(error){
      print(error.toString());
      emit(GetResultsError());
    }
  }
  
}
