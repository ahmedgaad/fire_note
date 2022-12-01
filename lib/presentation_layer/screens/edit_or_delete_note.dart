import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/dynamic_link_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/color_manager.dart';
import '../../core/style_manager.dart';

class EditOrDeleteNote extends StatefulWidget {
  QueryDocumentSnapshot noteDoc;
  EditOrDeleteNote(
    this.noteDoc, {
    Key? key,
  }) : super(key: key);

  @override
  _EditOrDeleteNoteState createState() => _EditOrDeleteNoteState();
}

class _EditOrDeleteNoteState extends State<EditOrDeleteNote> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;

  @override
  void initState() {
    _titleController =
        TextEditingController(text: widget.noteDoc['note_title']);
    _bodyController = TextEditingController(text: widget.noteDoc['note_body']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: ColorManager.secondary,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: ColorManager.secondary),
        centerTitle: true,
        title: Text(
          'Edit Or Delete Note',
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
                    FirebaseFirestore.instance
                        .collection("Notes")
                        .doc(widget.noteDoc.id)
                        .set({
                      "note_title": _titleController.text,
                      "note_body": _bodyController.text,
                    }).then((value) {
                      Navigator.pop(context);
                    }).catchError((error) {
                      print("Failed to add new note to $error");
                    });
                  }
                },
                icon: const Icon(
                  Icons.edit,
                ),
                label: const Text(
                  "Edit",
                  style: TextStyle(fontSize: 18.0),
                ),
                // ignore: prefer_const_constructors
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll<Color>(
                      ColorManager.darkOrange),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    FirebaseFirestore.instance
                        .collection("Notes")
                        .doc(widget.noteDoc.id)
                        .delete()
                        .then((value) {
                      Navigator.pop(context);
                    }).catchError((error) {
                      print("Failed to add new note to $error");
                    });
                  }
                },
                icon: const Icon(
                  Icons.delete,
                  // color: Colors.black,
                ),
                label: const Text(
                  "Delete",
                  style: TextStyle(fontSize: 18.0),
                ),
                // ignore: prefer_const_constructors
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 227, 23, 9)),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    DynamicLinkProvider()
                        .createLink(widget.noteDoc.id)
                        .then((value) {
                      Share.share(value);
                    });
                  }
                },
                icon: const Icon(
                  Icons.copy,
                  // color: Colors.black,
                ),
                label: const Text(
                  "Copy Link",
                  style: TextStyle(fontSize: 18.0),
                ),
                // ignore: prefer_const_constructors
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 99, 138, 102)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
