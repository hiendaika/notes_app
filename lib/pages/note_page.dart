import 'package:flutter/material.dart';
import 'package:notes_app/components/note_tile.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  //TextController access to TextField
  final TextEditingController textEditingController = TextEditingController();

  // create a note
  void createNote(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Note'),
            content: TextField(controller: textEditingController),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              MaterialButton(
                onPressed: () {
                  context.read<NoteDatabase>().addNote(
                    textEditingController.text,
                  );
                  Navigator.pop(context);
                },
                child: Text('Create'),
              ),
            ],
          ),
    );
  }

  // read a note
  void readNotes() {
    context.watch<NoteDatabase>().fetchNotes();
  }

  // update a note

  // delete a note
  @override
  Widget build(BuildContext context) {
    // NoteDatabase
    final noteDatabase = context.watch<NoteDatabase>();
    //Current note
    List<Note> currentNotes = noteDatabase.currentNotes;
    return Scaffold(
      appBar: AppBar(title: Text('Note app'), centerTitle: true),
      body: ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (context, index) {
          final note = currentNotes[index];
          return NoteTile(note: note);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
