import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/database_cubit/database_cubit.dart';
import '../../shared/widgets/note_card.dart';
import '../add_new_task/add_new_note.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
            bottom: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    hintText: "Search...."
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "All ToDos",
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Expanded(
                child: BlocConsumer<DatabaseCubit, DatabaseState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var cubit = DatabaseCubit.get(context);
                    if(state is GetAllNotesLoading){
                     return const Center(
                       child: CircularProgressIndicator(),
                     );
                    }
                    else if(state is GetAllNotesError){
                      return Center(
                        child: Text(
                          state.message,
                        ),
                      );
                    }
                    else {
                      if(cubit.allNotes.isEmpty){
                        return const Center(
                          child: Text(
                            "There's no notes right now",
                          ),
                        );
                      }
                      else {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return NoteCard(
                              note:cubit.allNotes[index],
                            );
                          },
                          itemCount: cubit.allNotes.length,
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewNote(),
              ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
