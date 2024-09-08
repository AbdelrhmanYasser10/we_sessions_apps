import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:we_session1/e-commerce_application/model/home_model.dart';
import 'package:we_session1/e-commerce_application/shared/network/local/cache_helper/cache_helper.dart';
import 'package:we_session1/e-commerce_application/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:we_session1/e-commerce_application/shared/network/remote/endpoints/endpoints.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context)=>BlocProvider.of(context);
  HomeModel? homeModel;

  void getHomeData()async{
    emit(GetHomeDataLoading());
    Response response = await DioHelper.getRequest(
        endPoint: HOME,
        token: CacheHelper.getStringFromCache("token"),
    );
    homeModel = HomeModel.fromJson(response.data);
    if(homeModel!.status!){
      emit(GetHomeDataSuccess());
    }
    else{
      emit(GetHomeDataError());
    }
  }
}
