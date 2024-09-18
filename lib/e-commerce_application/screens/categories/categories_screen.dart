import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_session1/e-commerce_application/shared/cubit/app_cubit/app_cubit.dart';


class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getCategoriesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppCubit,AppState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          if(state is GetCategoriesDataLoading || cubit.categoriesModel == null){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(state is GetCategoriesDataError){
            return  const Center(
              child: Row(
                children: [
                  Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  Text(
                    "Get Categories Error",
                  ),
                ],
              ),
            );
          }
          else{
            throw UnimplementedError();
          }
        },
      ),
    );
  }
}
