import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynote/controller/note_controller.dart';
import 'package:mynote/modals/not_obj.dart';

import 'package:search_page/search_page.dart';

class RecycleBinPage extends StatelessWidget {
  const RecycleBinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteController controller = Get.find();
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        title: const Text('Recycle Bin'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: SearchPage<NoteObj>(
                        searchLabel: 'Notes Search',
                        suggestion: const Center(
                            child: Text('Search you want to find')),
                        failure: const Center(
                          child: Text('Nothing Notes'),
                        ),
                        builder: (trash) => InkWell(
                              onTap: () {
                                Get.offAndToNamed('/editPage',
                                    arguments: {"id": trash.id});
                              },
                              child: ListTile(
                                title: Text(trash.title.toString()),
                                subtitle: Text(trash.note.toString()),
                                trailing: Text(trash.creatat.toString()),
                              ),
                            ),
                        filter: (trash) =>
                            [trash.title, trash.note, trash.creatat],
                        items: controller.trashNotes));
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: Obx(() => ListView.builder(
          itemCount: controller.trashNotes.length,
          itemBuilder: (context, idx) {
            return InkWell(
              onTap: () {
                Get.toNamed("/noteview", arguments: {"idx": idx, "page": 3});
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  isThreeLine: true,
                  title: Text(
                    trimString(
                        text: controller.trashNotes[idx].title.toString()),
                    maxLines: 1,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          trimString(
                              text: controller.trashNotes[idx].note.toString()),
                          maxLines: 2),
                      Text(controller.trashNotes[idx].creatat.toString())
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.trashNoteById(
                              restoreNote(
                                  controller.trashNotes[idx].trash!.toInt()),
                              controller.trashNotes[idx].id!);
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: const Text(
                                "Success, Restored Note",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              action: SnackBarAction(
                                label: "All Notes",
                                textColor: Colors.black,
                                onPressed: () {
                                  Get.toNamed('/home');
                                },
                              ),
                              backgroundColor: Colors.green));
                        },
                        icon: const Icon(Icons.restore),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                                title: "Are you Sure?",
                                titleStyle: const TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold),
                                content: Text(
                                  trimStringd(
                                    text: controller.trashNotes[idx].title
                                        .toString(),
                                  ),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                confirm: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red),
                                    onPressed: () {
                                      controller.deleteNotebyId(
                                          controller.trashNotes[idx].id!);
                                      Get.back();
                                    },
                                    child: const Text("Yes")),
                                cancel: ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text("No")));
                          },
                          icon: const Icon(Icons.delete_forever_outlined)),
                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }
}

int restoreNote(int value) {
  return value == 0 ? 1 : 0;
}

String trimString({required String text}) {
  if (text.length > 34) {
    var trimText = text.substring(0, 32) + "...";

    return trimText;
  } else {
    return text;
  }
}

String trimStringd({required String text}) {
  if (text.length > 34) {
    var trimText = text.substring(0, 25) + "...";

    return trimText;
  } else {
    return text;
  }
}
