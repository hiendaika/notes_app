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

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    //On app startup
    readNotes();
  }

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
                  //clear text field
                  textEditingController.clear();
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
    context.read<NoteDatabase>().fetchNotes();
  }

  // update a note
  void updateNote(BuildContext context, Note note) {
    //pre-fill current text
    textEditingController.text = note.text;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Update Note'),
            content: TextField(
              controller: textEditingController,
              autofocus: true,
            ),
            actions: [
              //Cancel button
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),

              //Update button
              MaterialButton(
                onPressed: () {
                  context.read<NoteDatabase>().updateNote(
                    note.id,
                    textEditingController.text,
                  );
                  //clear text field
                  textEditingController.clear();
                  Navigator.pop(context);
                },
                child: Text('Update'),
              ),
            ],
          ),
    );
  }

  // delete a note
  void deleteNote(Note note) {
    context.read<NoteDatabase>().deleteNote(note.id);
  }

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
          return NoteTile(
            note: note,
            deleteNote: () => deleteNote(note),
            updateNote: () => updateNote(context, note),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
