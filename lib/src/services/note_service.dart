import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:notes/src/models/note.dart';

class NoteService {
  final String baseUrl = 'https://dummyjson.com/posts';

  //Fetch Notes items
  Future<List<Note>> getNotes() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => Note.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load Notes');
    }
  }

  //create a note
  Future<Note> createNote(Note note) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(note.toJson()),
    );

    if (response.statusCode == 201) {
      return Note.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to Create Note');
    }
  }

  //Update note item
  Future<Note> updateNote(Note note) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${note.id}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(note.toJson()),
    );

    if (response.statusCode == 200) {
      return Note.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update todo');
    }
  }

  //Delete a Note
  Future<void> deleteNote(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response != 200) {
      throw Exception('Failed to delete Note');
    }
  }
}
