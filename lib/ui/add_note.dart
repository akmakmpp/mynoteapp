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
          var isValid = controller.formkey.currentState!.validate();
          if (isValid) {
            controller.addNote();
          }
        },
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: controller.formkey,
          child: ListView(
            children: [
              TextFormField(
                controller: controller.titleController,
                validator: (title) {
                  if (title!.isEmpty || title.trim().isEmpty) {
                    return "required";
                  } else
                    null;
                },
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
              TextFormField(
                controller: controller.noteController,
                validator: (note) {
                  if (note!.isEmpty || note.trim().isEmpty) {
                    return "required";
                  } else
                    null;
                },
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
      ),
    );
  }
}
