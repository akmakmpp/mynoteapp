import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynote/controller/note_controller.dart';

class NoteView extends StatelessWidget {
  const NoteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NoteController controller = Get.find();
    int idx = Get.arguments["idx"];
    int page = Get.arguments["page"];
    var noteList = page == 1
        ? controller.notes
        : page == 2
            ? controller.favouriteNote
            : controller.trashNotes;

    return Scaffold(
        appBar: AppBar(
          title: const Text('My Note'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.offAndToNamed(
                    '/editPage',
                    arguments: {"id": noteList[idx].id},
                  );
                },
                icon: const Icon(Icons.edit)),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Text(noteList[idx].creatat.toString()),
            const SizedBox(
              height: 30,
            ),
            Text(
              noteList[idx].title.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(
              thickness: 2.0,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(noteList[idx].note.toString())
          ],
        ));
  }
}
