import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:notes_app/db/database_provider.dart';
import 'package:notes_app/models/note_model.dart';
import 'dart:core';
// import 'package:notes_app/utils/color.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  late String title;
  late String body;
  late DateTime dateTime;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  addNote(NoteModel note) async {
    DatabaseProvider.db.addnewNote(note);
    print("add data successfully");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Note",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey,
        centerTitle: true,
        actions: [
          IconButton(
              color: Colors.white,
              onPressed: () {},
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter Your Title",
              ),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: TextField(
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Your body",
                ),
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            title = titleController.text.trim();
            body = bodyController.text.trim();
            dateTime = DateTime.now();
          });
          NoteModel note =
              NoteModel(title: title, body: body, dateTime: dateTime);
          addNote(note);
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/',
            (route) => false,
          );
        },
        label: Text("save note"),
        icon: Icon(Icons.save_as_rounded),
      ),
    );
  }
}
