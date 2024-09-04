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


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_session1/news_application/cubit/news_cubit.dart';
import 'package:we_session1/news_application/screen/layout/main_layout.dart';

import 'news_application/shared/network/dio_helper.dart';

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
      create: (context) =>
      NewsCubit()
        ..getSliderNews()
        ..getTopHeadlines(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainLayout(),
      ),
    );
  }
}

