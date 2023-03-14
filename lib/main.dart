import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/models/note_data.dart';
import 'package:notes_app/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox('note_database');
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>NoteData(),
    builder: (context, child)=>const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
    );
  }
}
