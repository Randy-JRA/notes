import 'package:flutter/material.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Note',
        ),
      ),
      body: Column(
        children: [
          const Text('Title'),
          const Text('Note'),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Close',
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
