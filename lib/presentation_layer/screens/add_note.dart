import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/color_manager.dart';

class AddNote extends StatefulWidget {
  const AddNote({
    Key? key,
  }) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: ColorManager.secondary,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: ColorManager.secondary),
        centerTitle: true,
        title: Text(
          'Add New Note',
          style: GoogleFonts.aclonica(
            color: Colors.black,
            fontSize: 24.0,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorManager.darkOrange,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        16.0,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: _titleController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Title Can't be empty";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Title",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                    ),
                    minLines: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Container(
                  // height: 250,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorManager.darkOrange,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        16.0,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: _bodyController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Body Can't be empty";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Body",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                    ),
                    maxLines: 6,
                    minLines: 6,
                  ),
                ),
              ),
              const SizedBox(
                height: 14.0,
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    FirebaseFirestore.instance.collection("Notes").add({
                      "note_title": _titleController.text,
                      "note_body": _bodyController.text,
                    }).then((value) {
                      print(value.id);
                      Navigator.pop(context);
                    }).catchError((error) {
                      print("Failed to add new note to $error");
                    });
                  }
                },
                icon: const Icon(
                  Icons.save,
                  color: Colors.black,
                ),
                label: const Text(
                  "Save",
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
                // ignore: prefer_const_constructors
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll<Color>(
                      ColorManager.darkOrange),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
