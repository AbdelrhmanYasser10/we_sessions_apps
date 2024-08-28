import 'package:flutter/material.dart';

import '../../cubit/database_cubit/database_cubit.dart';
import '../../model/note_model.dart';


class NoteCard extends StatefulWidget {
  final NoteModel note;
  const NoteCard({super.key , required this.note});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            SizedBox(
              width:50,
              height: 50,
              child: Transform.scale(
                scale:1.5,
                child: Checkbox(
                  value: widget.note.isDone,
                  onChanged: (value) {
                    setState(() {
                      widget.note.isDone = value!;
                      DatabaseCubit.get(context).updateNote(note: widget.note);
                    });
                  },
                  activeColor: Colors.green,
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.note.title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.note.description,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.note.date,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.blueGrey.shade500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                DatabaseCubit.get(context).deleteNote(id: widget.note.id!);
                DatabaseCubit.get(context).getAllData();
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
