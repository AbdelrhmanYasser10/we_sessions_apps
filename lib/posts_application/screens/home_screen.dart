import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_session1/posts_application/cubit/posts_cubit.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Posts",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<PostsCubit,PostsState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = PostsCubit.get(context);
          if(state is GetAllPostsLoading){
            return const Center(
              child: CircularProgressIndicator(

              ),
            );
          }
         return Padding(
           padding: const EdgeInsets.only(
               top: 10.0,
              right: 10.0,
             left: 10.0,
             bottom: 10.0
           ),
           child: ListView.separated(
               itemBuilder: (context, index) {
                 return Card(
                   child: Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: Column(
                       children: [
                         Text(
                             cubit.allPosts[index].title.toString(),
                           style: const TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 24.0,
                           ),
                           textAlign: TextAlign.center,
                           maxLines: 2,
                           overflow: TextOverflow.ellipsis,
                         ),
                         const Divider(),
                         Text(
                           cubit.allPosts[index].body.toString(),
                           textAlign: TextAlign.center,
                           style: const TextStyle(
                             fontWeight: FontWeight.w400,
                             fontSize: 18.0,
                           ),
                           maxLines: 3,
                           overflow: TextOverflow.ellipsis,
                         ),
                       ],
                     ),
                   ),
                 );
               },
               separatorBuilder: (context, index) {
                 return const SizedBox(
                   height: 10.0,
                 );
               },
               itemCount: cubit.allPosts.length,
           ),
         );
        },
      ),
    );
  }
}
