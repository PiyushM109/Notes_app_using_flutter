import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/models/note_data.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import 'editing_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    
    super.initState();
    Provider.of<NoteData>(context, listen: false).initializeNotes();
  }

  //create a new Node
  void createNewNote(){
    //create a new id
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    //create a blank note
    Note newNote = Note(
      id: id, 
      text: '',
      );

    //go to edit the blank note
    goToNotePage(newNote, true);
  }
  void goToNotePage(Note note, bool isNewNote){
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context)=>EditingNotePge(
          note: note,
          isNewNote: isNewNote,
        ),
        )
        );
  }

  void deleteNote(Note note){
    Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child)=>Scaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      floatingActionButton: FloatingActionButton(
        onPressed: createNewNote,
        elevation: 0,
        backgroundColor: Colors.grey[350],
        child: const Icon(Icons.add,
        color: Colors.grey,),
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          const Padding(
              padding : const EdgeInsets.only(left: 25.0, top: 75.0),
              child: Text('Notes', 
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,),),
          ),

        //list of Notes
         value.getAllNotes().length==0 ? 
         Padding(
           padding: const EdgeInsets.only(top: 50.0),
           child: Center(
            child: Text('Nothing Here..',
                          style: TextStyle(color: Colors.grey[400]),),
           ),
         )
         :CupertinoListSection.insetGrouped(
          children: List.generate(
            value.getAllNotes().length,
            (index) => CupertinoListTile(
              title: Text(value.getAllNotes()[index].text),
              onTap:()=> goToNotePage(value.getAllNotes()[index], false),

              trailing: IconButton(
                onPressed: ()=>
                    deleteNote(value.getAllNotes()[index]),
                     icon: Icon(Icons.delete)),

            )),
        )
        ],
        ),
    ),
    );
  }
}