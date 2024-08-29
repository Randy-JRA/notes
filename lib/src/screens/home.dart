import 'package:flutter/material.dart';
import 'package:notes/src/models/note.dart';
import 'package:notes/src/screens/add.dart';
import 'package:notes/src/services/note_service.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});
https://github.com/Randy-JRA/note_book_api
  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final NoteService noteService = NoteService();
  late Future<List<Note>> futureNotes;

  @override
  void initState() {
    super.initState();
    futureNotes = noteService.getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: FutureBuilder<List<Note>>(
        future: futureNotes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final notes = snapshot.data!;
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return ListTile(
                  title: Text(note.title),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(
                        () {
                          noteService.deleteNote(note.id);
                          futureNotes = noteService.getNotes();
                        },
                      );
                    },
                  ),
                );
              },
            );
          }
        } else {
          return Center(child:Text('No Notes Found'),);
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNote()));
        },
      ),
    );
  }
}
