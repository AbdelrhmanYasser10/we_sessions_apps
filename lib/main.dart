import 'package:flutter/material.dart';
import 'package:we_session1/e-commerce_application/shared/network/remote/dio_helper/dio_helper.dart';

import 'e-commerce_application/screens/login_screen/login_screen.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.initializeDio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
