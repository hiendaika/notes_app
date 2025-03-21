import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:notes_app/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  //Initialize database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  //List of note
  final List<Note> currentNotes = [];

  //Create a note and save to db
  Future<void> addNote(String textFromUser) async {
    //create a new note object
    final newNote = Note()..text = textFromUser;

    //save note to db
    await isar.writeTxn(() => isar.notes.put(newNote));

    //Reread from db
    fetchNotes();
  }

  // Read notes from db
  Future<void> fetchNotes() async {
    List<Note> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    notifyListeners();
  }

  // Update a note in db
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  //Delete a note in db
  Future<void> deleteNote(int noteId) async {
    await isar.writeTxn(() => isar.notes.delete(noteId));
    await fetchNotes();
  }
}
