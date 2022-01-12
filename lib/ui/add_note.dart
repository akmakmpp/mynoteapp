import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynote/controller/note_controller.dart';

class AddNote extends StatelessWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NoteController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.clear();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_outlined),
          ),
          title: const Text("Add Note")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addNote();
        },
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            TextField(
              controller: controller.titleController,
              decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  label: Text('Title'),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10.0)),
            ),
            const Divider(
              indent: 5.0,
              endIndent: 5.0,
              thickness: 3.0,
            ),
            TextField(
              controller: controller.noteController,
              maxLines: null,
              decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  label: Center(
                    child: Text(
                      'Write your note',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10.0)),
            ),
          ],
        ),
      ),
    );
  }
}
