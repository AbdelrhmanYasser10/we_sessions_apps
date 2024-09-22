import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context)=>BlocProvider.of(context);

  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;
  final _database = FirebaseFirestore.instance;

  final picker = ImagePicker();
  XFile? pickedImage;
  CroppedFile? finalImage;

  void pickImage() async {
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      emit(GetImageSuccessfully());
    }
    else {
      emit(GetImageError());
    }
  }

  void cropImage() async {
    finalImage = await ImageCropper().cropImage(
      sourcePath: pickedImage!.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),

      ],
    );
    if (finalImage == null) {
      emit(CropImageError());
    }
    else {
      emit(CropImageSuccesfully());
    }
  }

  void register({
    required String email,
    required String password,
    required String username,
  })  {
    emit(RegisterLoading());
     _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((user) {
       _storage.ref(
           "usersImages"
       ).
       child(finalImage!
           .path
           .split("/")
           .last).
       putFile(
         File(
             finalImage!.path
         ),
       ).then((value){
         /*after upload*/
         _storage.ref(
             "usersImages"
         ).
         child(finalImage!
             .path
             .split("/")
             .last).
         getDownloadURL().then((imageLink){
           _database.
           collection("users")
               .doc(
             _auth.currentUser!.uid,
           ).set({
             "email": email,
             "username": username,
             "imageLink": imageLink,
             "online": true,
           }).then((value) {
             emit(RegisterSuccesfully());
           }).catchError((error){
             emit(RegisterWithError());
           });
         }).catchError((error){
           emit(RegisterWithError());
         });
       }).catchError((error){
         emit(RegisterWithError());
       });
     }).catchError((error){
       emit(RegisterWithError());
     });


  }

  void login({required String email,required String password}){
    emit(LoginLoading());
    _auth.signInWithEmailAndPassword(email: email, password: password).
    then((value) {
      emit(LoginSuccesfully());
    }).catchError((error){
      emit(LoginWithError());
    });
  }
}
