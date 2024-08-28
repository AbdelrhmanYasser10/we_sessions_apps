import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/database_cubit/database_cubit.dart';
import '../../model/note_model.dart';
import '../../shared/widgets/my_text_form_field.dart';


class AddNewNote extends StatefulWidget {
  const AddNewNote({Key? key}) : super(key: key);

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add new Note",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyTextFormField(
              hint: "Title",
              icon: const Icon(
                Icons.edit,
              ),
              controller: _titleController,
            ),
            MyTextFormField(
              hint: "Description",
              icon: Icon(
                Icons.edit,
              ),
              controller: _descriptionController,
            ),
            MyTextFormField(
              hint: "Date",
              icon: Icon(
                Icons.date_range,
              ),
              controller: _dateController,
            ),
            BlocConsumer<DatabaseCubit, DatabaseState>(
              listener: (context, state) {
                if(state is AddNoteSucessfully){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        "Added Successfully",
                      ),
                    ),
                  );
                  Navigator.pop(context);
                  DatabaseCubit.get(context).getAllData();
                }
                else if(state is AddNoteError){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                        content: Text(
                          state.message,
                        ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if(state is AddNoteLoading){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 55),
                        backgroundColor: Colors.red),
                    onPressed: () {
                      DatabaseCubit.get(context).addNewNote(
                          note: NoteModel(
                              title: _titleController.text,
                              description:_descriptionController.text,
                              date: _dateController.text,
                              isDone: false,
                          ),
                      );
                    },
                    child: const Text(
                      "+Add",
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
