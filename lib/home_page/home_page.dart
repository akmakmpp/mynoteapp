import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mynote/modals/menu_item_modal.dart';
import 'package:mynote/modals/menu_items.dart';
import 'package:mynote/modals/not_obj.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mynote/controller/note_controller.dart';
import 'package:mynote/drawer_page/drawer_page.dart';

import 'package:search_page/search_page.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteController controller = Get.put(NoteController());

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        title: const Text('All notes'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: SearchPage<NoteObj>(
                        searchLabel: 'Search Notes',
                        suggestion: const Center(child: Text('Search Notes')),
                        failure: const Center(
                          child: Text('Not found'),
                        ),
                        builder: (note) => ListTile(
                              onTap: () {
                                Get.offAndToNamed('/editPage',
                                    arguments: {"id": note.id});
                              },
                              title: Text(note.title.toString()),
                              subtitle: Text(note.note.toString()),
                              trailing: Text(note.creatat.toString()),
                            ),
                        filter: (note) => [note.title, note.note, note.creatat],
                        items: controller.notes));
              },
              icon: const Icon(Icons.search)),
          PopupMenuButton<MenuItem>(
            itemBuilder: (context) => [
              ...MenuItems.itemList.map((item) {
                return PopupMenuItem<MenuItem>(
                    value: item,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.text,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        FaIcon(
                          item.icon,
                          color: Colors.black,
                        ),
                      ],
                    ));
              }).toList(),
            ],
            onSelected: (item) => onSelected(context, item),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/add');
        },
        child: const Icon(Icons.add),
      ),
      drawer: const DrawerPage(),
      body: Obx(() => ListView.builder(
          itemCount: controller.notes.length,
          itemBuilder: (context, idx) {
            return InkWell(
              onTap: () {
                Get.toNamed("/noteview", arguments: {"idx": idx, "page": 1});
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
                      text: controller.notes[idx].title.toString(),
                    ),
                    maxLines: 1,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trimString(
                          text: controller.notes[idx].note.toString(),
                        ),
                        maxLines: 2,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(controller.notes[idx].creatat.toString(),
                          style: TextStyle(
                              color: Colors.blueGrey[900], fontSize: 12)),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            controller.favoriteById(
                                favoriteInvert(
                                    controller.notes[idx].favourite!.toInt()),
                                controller.notes[idx].id!);
                          },
                          icon: favoriteInvert(controller.notes[idx].favourite!
                                      .toInt()) ==
                                  1
                              ? const Icon(Icons.favorite_border)
                              : const Icon(Icons.favorite)),
                      IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                                title: "Move to trash?",
                                titleStyle: const TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold),
                                content: Text(
                                  trimStringd(
                                    text:
                                        controller.notes[idx].title.toString(),
                                  ),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                confirm: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red),
                                    onPressed: () {
                                      controller.trashNoteById(
                                          favoriteInvert(controller
                                              .notes[idx].trash!
                                              .toInt()),
                                          controller.notes[idx].id!);
                                      Get.back();
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                              content: const Text(
                                                "Success, Move to trash",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              action: SnackBarAction(
                                                label: "Recycle Bin",
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  Get.toNamed('/recycleBin');
                                                },
                                              ),
                                              backgroundColor: Colors.red));
                                    },
                                    child: const Text("Yes")),
                                cancel: ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text("No")));
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }
}

onSelected(BuildContext context, MenuItem item) {
  String _url = "https://github.com/akmakmpp/mynoteapp";
  void _launchURL() async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  switch (item) {
    case MenuItems.itemAboutUs:
      Get.defaultDialog(
          contentPadding: const EdgeInsets.only(left: 100, right: 100),
          title: "My Note",
          titleStyle: const TextStyle(
              color: Colors.orange, fontWeight: FontWeight.bold),
          content: const Text(
            "Version 1.0.0",
            style: TextStyle(color: Colors.red),
          ));
      break;

    case MenuItems.itemGithubLink:
      _launchURL();
      break;
  }
}

int favoriteInvert(int value) {
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
