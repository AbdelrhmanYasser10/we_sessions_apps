import 'package:sqflite/sqflite.dart';

import '../model/note_model.dart';

abstract class DatabaseHelper{
   static Database? _database;
   static Future<void> initialize() async{
     var databasesPath = await getDatabasesPath();
     String path = "${databasesPath}note.db";
     _database = await openDatabase(
       path,
       version: 1,
       onCreate: (db, version) async{
         await db.execute(
             'CREATE TABLE Note (id INTEGER PRIMARY KEY, title TEXT, description TEXT, date TEXT, status INTEGER)');
       },
       onOpen: (db) {
         print("Database Opened!!");
       },
     );
   }
   //CRUD
   static Future<void> insert({required NoteModel note}) async{
     if(_database != null){
       int result = await _database!.insert("Note", note.toMap());
       if(result != 0){
         print("Inserted Successfully");
       }
       else{
         print("Error while inserting a value");
       }
     }
   }
   static Future<List<NoteModel>> getAllData()async{
     if(_database != null) {
      List<Map<String,dynamic>> allData = await _database!.query("Note");
      List<NoteModel> allNotes = [];
      for(var element in allData){
        NoteModel note = NoteModel.fromMap(element);
        allNotes.add(note);
      }
      return allNotes;
     }
     return [];

   }
   static Future<NoteModel?> getSpecificQuery({required int id})async{
      if(_database !=null){
        try {
          Map<String,dynamic> tempMap = (await _database!.query("Note", where: "id = ?", whereArgs: [id]))[0];
          return NoteModel.fromMap(tempMap);
        }catch(error){
          print("This id is not founded");
        }
      }
      return null;
   }
   static Future<NoteModel?> getSpecificNote({required String title})async{
     if(_database !=null){
       try {
         Map<String,dynamic> tempMap = (await _database!.query("Note", where: "title = ?", whereArgs: [title]))[0];
         return NoteModel.fromMap(tempMap);
       }catch(error){
         print("This id is not founded");
       }
     }
     return null;
   }
   static Future<void> updateQuery({required NoteModel note})async{
     if(_database != null){
       await _database!.update("Note", note.toMap(),where: "id = ?" ,whereArgs: [note.id]);
     }
   }

   static Future<void> deleteNote({required int id})async{
     if(_database != null){
      await _database!.delete("Note",where: "id = ?",whereArgs: [id]);
     }
   }
}