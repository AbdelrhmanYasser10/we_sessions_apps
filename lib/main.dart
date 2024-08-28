//Note application main
/*
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Database initializer
  await DatabaseHelper.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DatabaseCubit()..getAllData(),
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}*/


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_session1/posts_application/screens/home_screen.dart';
import 'package:we_session1/posts_application/cubit/posts_cubit.dart';
import 'package:we_session1/posts_application/dio_helper/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.initializeDio();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit()..getAllPosts(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

