import 'package:get/get.dart';
import 'note_controller.dart';

class NoteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoteController());
  }
}
