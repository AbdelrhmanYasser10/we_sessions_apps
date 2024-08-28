import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:we_session1/posts_application/dio_helper/dio_helper.dart';

import '../models/posts_model.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());
static PostsCubit get(context)=>BlocProvider.of(context);

  List<PostsModel> allPosts = [];

  void getAllPosts() async{
    emit(GetAllPostsLoading());
    try {
      Response r = await DioHelper.getRequest(endPoint: "posts");
      if (r.statusCode == 200) {
        for (var element in r.data){
          allPosts.add(PostsModel.fromJson(element));
        }
        emit(GetAllPostsSuccess());
      }
      else {
        emit(GetAllPostsError());
      }
    }catch(error){
     emit(GetAllPostsError());
    }
  }

}
