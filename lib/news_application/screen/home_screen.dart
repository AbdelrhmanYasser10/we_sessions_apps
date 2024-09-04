import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_session1/news_application/cubit/news_cubit.dart';
import 'package:we_session1/news_application/model/news_model.dart';

import '../shared/widgets/news_card.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: BlocConsumer<NewsCubit, NewsState>(
            listener: (context, state) {
              if(state is GetSliderNewsError){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                      content: Text(
                        "Error while getting slider news",
                      ),
                  ),
                );
              }
            },
            builder: (context, state) {
              var cubit = NewsCubit.get(context);
              if(state is GetSliderNewsLoading || cubit.sliderNews == null){
                return const Center(
                  child: LinearProgressIndicator(),
                );
              }
              else if(state is GetSliderNewsError){
                return const SizedBox();
              }
              return CarouselSlider(
                items: martin(cubit.sliderNews!.articles!),
                options: CarouselOptions(
                  height: 400,
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
              );
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Breaking news",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                BlocConsumer<NewsCubit,NewsState>(
                  listener: (context, state) {
                    if(state is GetBreakingNewsError){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                            content: Text(
                              "Error while getting breaking news",
                            ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    var cubit = NewsCubit.get(context);

                    if(state is GetBreakingNewsLoading || cubit.topHeadlines == null){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else if(state is GetBreakingNewsError){
                      return SizedBox();
                    }
                    return Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return NewsCard(
                              title:cubit.topHeadlines!.articles![index].title ,
                              description: cubit.topHeadlines!.articles![index].description,
                              imageLink: cubit.topHeadlines!.articles![index].urlToImage,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10.0,
                            );
                          },
                          itemCount: cubit.topHeadlines!.articles!.length,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget newsSliderCard({
  required String? urlToImage,
  required String? title,
  required String? description,
  required String? author,
}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                urlToImage ?? "https://media.istockphoto.com/id/1369150014/vector/breaking-news-with-world-map-background-vector.jpg?s=612x612&w=0&k=20&c=9pR2-nDBhb7cOvvZU_VdgkMmPJXrBQ4rB1AkTXxRIKM=",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title??"[Title]",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  description??"[Description]",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  author??"[Author]",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> martin(List<Articles> articles){
    if(articles.isNotEmpty){
      List<Widget> allCards = [];
      if(articles.length >= 5){
        for(int i = 0 ; i < 5;i++){
          allCards.add(newsSliderCard(
            urlToImage: articles[i].urlToImage,
            title: articles[i].title,
            description: articles[i].description,
            author: articles[i].author,
          ),
          );
        }
      }
      else{
        for(int i = 0 ; i < articles.length;i++){
          allCards.add(newsSliderCard(
              urlToImage: articles[i].urlToImage,
              title: articles[i].title,
              description: articles[i].description,
              author: articles[i].author,
            ),
          );
        }
      }
      return allCards;
    }
    else {
      return [];
    }
  }


}
