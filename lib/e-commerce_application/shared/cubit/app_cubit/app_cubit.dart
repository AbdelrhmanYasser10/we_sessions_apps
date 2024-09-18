import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:we_session1/e-commerce_application/model/cateogires_model.dart';
import 'package:we_session1/e-commerce_application/model/favourite_model.dart';
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
  FavouriteModel? favouriteModel;

  Map<int,bool> favMap = {};
  void getHomeData()async{
    emit(GetHomeDataLoading());
    Response response = await DioHelper.getRequest(
        endPoint: HOME,
        token: CacheHelper.getStringFromCache("token"),
    );
    homeModel = HomeModel.fromJson(response.data);
    if(homeModel!.status!){
      for(var element in homeModel!.data!.products!){
        favMap.addAll({
          element.id! : element.inFavorites!,
        });
      }
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

  void changeProductFavourite({required int productId}) async
  {
    favMap[productId] = !favMap[productId]!;
    emit(ChangeProductFavouriteSuccessfully());
    Response r = await DioHelper.postRequest(
        endPoint: "favorites",
        token: CacheHelper.getStringFromCache("token"),
      data: {
          "product_id":productId,
      }
    );
    print(CacheHelper.getStringFromCache("token"));
    print(r.data);
    if(r.data["status"]){
      getAllFavourites();
      emit(ChangeProductFavouriteSuccessfully());
    }
    else{
      favMap[productId] = !favMap[productId]!;
      emit(ChangeProductFavouriteError());
    }
  }

  void getAllFavourites()async{
    emit(GetFavouritesLoading());
    Response response = await DioHelper.
    getRequest(
        endPoint: "favorites",
        token: CacheHelper.getStringFromCache("token"),
    );
    try {
      favouriteModel = FavouriteModel.fromJson(response.data);
      if (favouriteModel!.status!) {
        emit(GetFavouritesSuccess());
      }
      else {
        emit(GetFavouritesError());
      }
    }catch(error){
      print(error);
      emit(GetFavouritesError());
    }
  }

}
