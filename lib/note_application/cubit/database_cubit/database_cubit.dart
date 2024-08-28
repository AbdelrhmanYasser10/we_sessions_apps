import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../database/database_helper.dart';
import '../../model/note_model.dart';

part 'database_state.dart';

class DatabaseCubit extends Cubit<DatabaseState> {
  DatabaseCubit() : super(DatabaseInitial());

  static DatabaseCubit get(context) => BlocProvider.of(context);
  List<NoteModel> allNotes = [];

  void getAllData() async {
    emit(GetAllNotesLoading());
    try {
      allNotes = await DatabaseHelper.getAllData();
      allNotes = allNotes.reversed.toList();
      emit(GetAllNotesSuccess());
    } catch (error) {
      print(error.toString());
      emit(GetAllNotesError(message: "Error while getting data"));
    }
  }

  void addNewNote({required NoteModel note}) async {
    emit(AddNoteLoading());
    try {
      await DatabaseHelper.insert(note: note);
      emit(AddNoteSucessfully());
    } catch (error) {
      emit(AddNoteError(message: "Cannot insert this note"));
    }
  }

  void updateNote({required NoteModel note}) async {
    emit(UpdateNoteLoading());
    try {
      await DatabaseHelper.updateQuery(note: note);
      emit(UpdateNoteSucessfully());
    } catch (error) {
      emit(UpdateNoteError(message: "This id doesn't exist"));
    }
  }

  void deleteNote({required int id}) async{
    emit(DeleteNoteLoading());
    try {
      await DatabaseHelper.deleteNote(id: id);
      emit(DeletedSuccesfullly());
    }catch(error){
      emit(DeletedError(message: "There's no id for this note"));
    }
  }
}
