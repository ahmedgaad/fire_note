import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/color_manager.dart';
import '../../core/routes_manager.dart';
import 'add_note.dart';
import 'edit_or_delete_note.dart';
import '../widgets/note_card.dart';

class Home extends StatelessWidget {
  Home({super.key});
  CollectionReference notes = FirebaseFirestore.instance.collection("Notes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ColorManager.secondary,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: ColorManager.secondary),
        centerTitle: true,
        title: Text(
          'FireNote',
          style: GoogleFonts.aclonica(
            color: Colors.black,
            fontSize: 24.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your recent Notes',
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: StreamBuilder(
                stream: notes.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.primary,
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      children: snapshot.data!.docs
                          .map((note) => NoteCard(note))
                          .toList(),
                    );
                  }
                  return Center(
                    child: Text(
                      "There's No Notes",
                      style: GoogleFonts.adamina(
                        color: Colors.black.withOpacity(20),
                        fontSize: 30.0,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(20.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, Routes.addNote);
          },
          label: Text(
            'Add Note',
            style: GoogleFonts.poppins(
              fontSize: 18.0,
            ),
          ),
          backgroundColor: ColorManager.primary,
          foregroundColor: Colors.black,
          icon: const Icon(
            Icons.add,
            color: Colors.black,
            size: 24.0,
          ),
        ),
      ),
    );
  }
}
