import 'package:flutter/material.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:notes_app/pages/note_page.dart';
import 'package:provider/provider.dart';

void main() async {
  //init note isar database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteDatabase(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: NotePage());
  }
}
