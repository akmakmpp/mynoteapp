import 'package:get/get.dart';
import 'package:mynote/controller/note_binding.dart';
import 'package:mynote/drawer_page/recycle_bin.dart';
import 'package:mynote/home_page/home_page.dart';
import 'package:mynote/ui/add_note.dart';
import 'package:mynote/ui/edit_page.dart';
import 'package:mynote/ui/favorite_page.dart';
import 'package:mynote/ui/note_view.dart';

class MyRoutes {
  static final routes = [
    GetPage(
        name: '/home', page: () => const HomePage(), binding: NoteBinding()),
    GetPage(name: '/add', page: () => const AddNote(), binding: NoteBinding()),
    GetPage(
        name: '/noteview',
        page: () => const NoteView(),
        binding: NoteBinding()),
    GetPage(
        name: '/favourite',
        page: () => const FavoritePage(),
        binding: NoteBinding()),
    GetPage(
        name: '/recycleBin',
        page: () => const RecycleBinPage(),
        binding: NoteBinding()),
    GetPage(
        name: '/editPage', page: () => const EditPage(), binding: NoteBinding())
  ];
}
