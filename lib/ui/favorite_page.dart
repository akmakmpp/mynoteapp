import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynote/controller/note_controller.dart';
import 'package:mynote/modals/not_obj.dart';

import 'package:search_page/search_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NoteController controller = Get.find();
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        title: const Text('My Favourite'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: SearchPage<NoteObj>(
                        searchLabel: 'Search Notes',
                        suggestion: const Center(child: Text('Search Notes')),
                        failure: const Center(
                          child: Text('Nothing Notes'),
                        ),
                        builder: (fnote) => ListTile(
                              onTap: () {
                                Get.offAndToNamed('/editPage',
                                    arguments: {"id": fnote.id});
                              },
                              title: Text(fnote.title.toString()),
                              subtitle: Text(fnote.note.toString()),
                              trailing: Text(fnote.creatat.toString()),
                            ),
                        filter: (fnote) =>
                            [fnote.title, fnote.note, fnote.creatat],
                        items: controller.favouriteNote));
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: Obx(() => ListView.builder(
          itemCount: controller.favouriteNote.length,
          itemBuilder: (context, idx) {
            return InkWell(
              onTap: () {
                Get.toNamed("/noteview", arguments: {"idx": idx, "page": 2});
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
                      text: controller.favouriteNote[idx].title.toString(),
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
                            text:
                                controller.favouriteNote[idx].note.toString()),
                        maxLines: 2,
                      ),
                      Text(controller.favouriteNote[idx].creatat.toString())
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            controller.favoriteById(
                                favoriteInvert(controller
                                    .favouriteNote[idx].favourite!
                                    .toInt()),
                                controller.favouriteNote[idx].id!);
                          },
                          icon: favoriteInvert(controller
                                      .favouriteNote[idx].favourite!
                                      .toInt()) ==
                                  1
                              ? const Icon(Icons.favorite_border)
                              : const Icon(Icons.favorite)),
                      IconButton(
                          onPressed: () {
                            controller.deleteNotebyId(
                                controller.favouriteNote[idx].id!);
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
