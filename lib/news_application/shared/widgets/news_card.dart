import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String? title;
  final String? imageLink;
  final String? description;
  const NewsCard({Key? key
  ,required this.title,
    required this.imageLink,
    required this.description
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title ?? "There's no title",
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
              description ?? "There's no description",
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
              imageLink ?? "https://media.istockphoto.com/id/1369150014/vector/breaking-news-with-world-map-background-vector.jpg?s=612x612&w=0&k=20&c=9pR2-nDBhb7cOvvZU_VdgkMmPJXrBQ4rB1AkTXxRIKM=",
            )
          ],
        ),
      ),
    );
  }
}
