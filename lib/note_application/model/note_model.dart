class NoteModel{

  int? id;
  late String title;
  late String description;
  late String date;
  late bool isDone;

  NoteModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isDone,
  });

  factory NoteModel.fromMap(Map<String,dynamic> map){
    return NoteModel(
        id: map["id"],
        title: map["title"],
        description: map["description"],
        date: map["date"],
        isDone: map['status'] == 1,
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "title":title,
      "description":description,
      "date":date,
      "status": isDone? 1 : 0,
    };
  }


}