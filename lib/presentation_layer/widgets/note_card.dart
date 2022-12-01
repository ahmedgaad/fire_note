import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../core/style_manager.dart';

import '../../core/color_manager.dart';
import '../screens/edit_or_delete_note.dart';

class NoteCard extends StatelessWidget {
  //Function() onTap;
  QueryDocumentSnapshot noteDoc;
  NoteCard(
    this.noteDoc, {
    //required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => EditOrDeleteNote(noteDoc)));
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: Border.all(color: ColorManager.darkOrange)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              noteDoc["note_title"],
              style: StyleManager.noteTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Divider(
              height: 8.0,
              color: ColorManager.darkPurple,
            ),
            Text(
              noteDoc["note_body"],
              style: StyleManager.noteBody,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
