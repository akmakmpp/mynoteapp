import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynote/controller/note_controller.dart';

class EditPage extends StatelessWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteController controller = Get.find();
    int id = Get.arguments["id"];
    // int trash = Get.arguments["trash"];
    // int favorite = Get.arguments["favorite"];
    controller.selectRowById(id);
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Note")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.updateNoteById(id);
          controller.clear();
          Get.back();
        },
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            TextField(
              controller: controller.titleController,
              maxLines: 2,
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
