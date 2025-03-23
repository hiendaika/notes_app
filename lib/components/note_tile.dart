import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  const NoteTile({
    super.key,
    required this.note,
    required this.deleteNote,
    required this.updateNote,
  });
  final Function() deleteNote;
  final Function() updateNote;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        note.text,
        style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Edit icon
          IconButton(
            onPressed: deleteNote(),
            icon: Icon(Icons.edit, color: Colors.grey.shade800),
          ),
          //Delete icon
          IconButton(
            onPressed: () => updateNote(),
            icon: Icon(Icons.delete, color: Colors.grey.shade800),
          ),
        ],
      ),
    );
  }
}
