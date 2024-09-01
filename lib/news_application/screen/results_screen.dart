import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_session1/news_application/cubit/news_cubit.dart';

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
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              cubit.results.articles![index].title ?? "There's no title",
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              cubit.results.articles![index].description ?? "There's no description",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Image.network(
                                cubit.results.articles![index].urlToImage ?? "https://media.istockphoto.com/id/1369150014/vector/breaking-news-with-world-map-background-vector.jpg?s=612x612&w=0&k=20&c=9pR2-nDBhb7cOvvZU_VdgkMmPJXrBQ4rB1AkTXxRIKM=",
                            )
                          ],
                        ),
                      ),
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
