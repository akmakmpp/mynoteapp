import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynote/controller/note_controller.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteController controller = Get.find();
    return Drawer(
        backgroundColor: Colors.grey[200],
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 10.0, top: 50),
              child: Text(
                'My Note',
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Divider(
              thickness: 2.0,
            ),
            ListTile(
              title: const Text('All Notes'),
              onTap: () {
                Get.back();
              },
              leading: const Icon(
                Icons.description,
                color: Colors.red,
              ),
            ),
            ListTile(
              title: const Text('Favourite Notes'),
              onTap: () {
                Get.toNamed('/favourite');
              },
              leading: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
            ListTile(
              title: const Text('Recycle Bin'),
              onTap: () {
                Get.toNamed('/recycleBin');
              },
              leading: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
            ),
            ListTile(
              title: const Text('Delete All Notes'),
              onTap: () {
                Get.defaultDialog(
                    title: "Are you Sure?",
                    titleStyle: const TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold),
                    content: const Text(
                      "Delete All Notes!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    confirm: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () {
                          controller.deleteAllNote();
                          Get.back();
                        },
                        child: const Text("Yes")),
                    cancel: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("No")));
              },
              leading: const Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
            )
          ],
        ));
  }
}
