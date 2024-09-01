import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:we_session1/news_application/cubit/news_cubit.dart';
import 'package:we_session1/news_application/screen/results_screen.dart';


class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: categoryCard(
                      icon: Icons.sports,
                      title: "Sports",
                      context: context,

                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: categoryCard(
                      icon: Icons.person_4,
                      title: "Business",
                      context: context,

                    ),
                  ),
                ],
              ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: categoryCard(
                    icon: Icons.science,
                    title: "Science",
                    context: context,

                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: categoryCard(
                    icon: Icons.biotech,
                    title: "Technology",
                    context: context,

                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: categoryCard(
                    icon: Icons.health_and_safety,
                    title: "Health",
                    context: context,

                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: categoryCard(
                    icon: Icons.video_label_outlined,
                    title: "Entertainment",
                    context: context,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector categoryCard({
  required String title,
    required IconData icon,
    required BuildContext context,
}){
    return GestureDetector(
      onTap: (){
        NewsCubit.get(context).getResults(categoryName: title.toLowerCase());
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context){
              return ResultsScreen(title: title);
            }),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 100,
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
