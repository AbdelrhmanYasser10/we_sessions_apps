import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:we_session1/e-commerce_application/model/cateogires_model.dart';
import 'package:we_session1/e-commerce_application/model/home_model.dart';
import 'package:we_session1/e-commerce_application/shared/network/local/cache_helper/cache_helper.dart';
import 'package:we_session1/e-commerce_application/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:we_session1/e-commerce_application/shared/network/remote/endpoints/endpoints.dart';

import '../../../model/user_model.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context)=>BlocProvider.of(context);
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  UserModel? user;
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

  void getCategoriesData()async{
    emit(GetCategoriesDataLoading());
    Response response = await DioHelper.getRequest(
        endPoint: "categories",
    );
    categoriesModel = CategoriesModel.fromJson(response.data);
    if(categoriesModel!.status!){
      emit(GetCategoriesDataSuccess());
    }
    else{
      emit(GetCategoriesDataError());
    }
  }

  void getUserData()async{
    emit(GetUserDataLoading());
    Response response = await DioHelper.getRequest(
      endPoint: "profile",
      token: CacheHelper.getStringFromCache("token") ??""
    );
    user = UserModel.fromJson(response.data);
    if(user!.status!){
      emit(GetUserDataSuccessfully());
    }
    else{
      emit(GetUserDataError());
    }

  }

}
