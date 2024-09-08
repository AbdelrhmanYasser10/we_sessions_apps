import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_session1/e-commerce_application/shared/cubit/app_cubit/app_cubit.dart';

import '../model/home_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getHomeData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppCubit,AppState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          if(state is GetHomeDataLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(state is GetHomeDataError){
            return Center(
              child: Column(
                children: [
                  Text(
                    "Error while getting home data",
                  ),
                  TextButton(
                      onPressed: (){
                        AppCubit.get(context).getHomeData();
                      },
                      child: Text(
                        "Reload",
                      ),
                  ),
                ],
              ),
            );
          }
          else{
            return Column(
              children: [
                CarouselSlider(
                  items: makeSliderItems(cubit.homeModel!.data!.banners!),
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  List<Widget> makeSliderItems(List<Banners> allBanners){
    List<Widget> allImages = [];
    for(var element in allBanners){
      allImages.add(
        Image.network(
          element.image ?? "https://c8.alamy.com/comp/MR0G79/random-pictures-MR0G79.jpg"
        ),
      );
    }
    return allImages;
  }
}
