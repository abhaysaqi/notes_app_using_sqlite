import 'dart:async';
// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:notes_app/db/database_provider.dart';
import 'package:notes_app/models/note_model.dart';
// import 'package:notes_app/screens/create_note.dart';
import 'package:notes_app/utils/color.dart';

class HomeScreen extends StatelessWidget {
  final List<String> notesList = [
    'abhay',
    'meri jaan',
    'abhimanyu',
    'ehsas',
    'sahil',
    'simran'
  ];
  Future fetchNotes() async {
    final notes = await DatabaseProvider.db.getNotes();
    return notes;
  }

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("My Notes",
            style: TextStyle(
              color: ColorsUtils.whiteColor,
            )),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Note",
        onPressed: () {
          Navigator.pushNamed(context, '/notes');
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.add,
        ),
      ),
      body: FutureBuilder(
        future: fetchNotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          try {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                if (snapshot.data == null) {
                  return const Center(
                    child: Text("You don't have any notes yet create one"),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        NoteModel note = snapshot.data[index];
                        // String title = snapshot.data[index]['title'];
                        // String body = snapshot.data[index]['body'];
                        // String datetime = snapshot.data[index]['dateTime'];
                        // int id = snapshot.data[index]['id'];
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/display', (route) => false,
                                  arguments: note);
                            },
                            title: Text(note.title),
                            subtitle: Text(note.title),
                          ),
                        );
                      },
                    ),
                  );
                }
              default:
                return const Center(
                  child: Text("data not found"),
                );
            }
          } catch (e) {
            print(e.toString());
            return Text(e.toString());
          }
        },
      ),
    );
  }
}
