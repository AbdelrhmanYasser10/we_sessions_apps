import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_session1/e-commerce_application/shared/cubit/app_cubit/app_cubit.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getUserData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          if(state is GetUserDataLoading || cubit.user == null){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Center(
            child: Text(
              cubit.user!.data!.email!,
            ),
          );
        },
      ),
    );
  }
}
