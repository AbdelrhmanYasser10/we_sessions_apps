import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_session1/news_application/cubit/news_cubit.dart';
import 'package:we_session1/news_application/shared/widgets/news_card.dart';

class ResultsScreen extends StatelessWidget {
  final String title;
  const ResultsScreen({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<NewsCubit,NewsState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          if(state is GetResultsLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(state is GetResultsError){
            return Center(
              child: Text(
                "Error while getting news"
              ),
            );
          }
          else{
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return NewsCard(
                        title: cubit.results.articles![index].title,
                        imageLink: cubit.results.articles![index].urlToImage,
                        description: cubit.results.articles![index].description,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10.0,
                    );
                  },
                  itemCount: cubit.results.articles!.length,
              ),
            );
          }
        },

      ),
    );
  }
}
