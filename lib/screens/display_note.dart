import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/db/database_provider.dart';
import 'package:notes_app/models/note_model.dart';

class DisplayNote extends StatelessWidget {
  const DisplayNote({super.key});

  @override
  Widget build(BuildContext context) {
    final NoteModel note= ModalRoute.of(context)?.settings.arguments as NoteModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("Your Note"),
        actions: [
          IconButton.filled(
              onPressed: () {
                DatabaseProvider.db.deleteRow(id: note.id!);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(note.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            Expanded(
              child: SingleChildScrollView(
                child: Text(note.body,
                    style: const TextStyle(
                      fontSize: 16,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
