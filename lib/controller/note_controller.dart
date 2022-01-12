import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:mynote/database/data_base.dart';

import 'package:flutter/material.dart';
import 'package:mynote/modals/not_obj.dart';

class NoteController extends GetxController {
  RxList<NoteObj> notes = <NoteObj>[].obs;
  RxList<NoteObj> favouriteNote = <NoteObj>[].obs;
  RxList<NoteObj> trashNotes = <NoteObj>[].obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  static final _db = NoteDatabase.instance;

  @override
  void onInit() {
    getAllNote();
    getAllFavouriteNote();
    getAllTrashNote();

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    titleController.dispose();
    noteController.dispose();
  }

  addNote() async {
    DateTime now = DateTime.now();
    String datetime = DateFormat("MMMM dd, yyyy /hh:mm a").format(now);
    NoteObj note = NoteObj(
        title: titleController.text,
        note: noteController.text,
        creatat: datetime);

    _db.insert(note.toMap());
    getAllNote();

    clear();
    Get.back();
  }

  getAllNote() async {
    final noteList = await _db.queryAllRows();
    notes.value = noteList;
    log("getAllNote" + noteList.toString());
  }

  deleteNotebyId(int idx) async {
    await _db.delete(idx);
    log(_db.delete(idx).toString());
    getAllNote();
    getAllFavouriteNote();
    getAllTrashNote();
  }

  favoriteById(int value, int idx) async {
    await _db.favoriteFunction(value, idx);
    getAllNote();
    getAllFavouriteNote();
    getAllTrashNote();
  }

  getAllFavouriteNote() async {
    final favNote = await _db.queryAllFavouriteRow();
    favouriteNote.value = favNote;
  }

  trashNoteById(int value, int idx) async {
    await _db.trashFunction(value, idx);
    getAllNote();
    getAllFavouriteNote();
    getAllTrashNote();
  }

  getAllTrashNote() async {
    final trashNote = await _db.queryAllTrashRow();
    trashNotes.value = trashNote;
    log("trash" + trashNote.toString());
  }

  deleteAllNote() async {
    try {
      await _db.deleleAll();
      getAllNote();
      getAllFavouriteNote();
      getAllTrashNote();
      Get.snackbar("Success", "All Note Deleted",
          colorText: Colors.white, backgroundColor: Colors.red);
    } catch (e) {
      Get.snackbar("Error", "Can't Delete All Note");
      throw Exception(e);
    }
  }

  selectRowById(int id) async {
    final Map<String, Object?> row = await _db.selectRowById(id);
    log("Edit Note " + row.toString());
    var note = NoteObj.fromJson(row);

    titleController.text = note.title.toString();
    noteController.text = note.note.toString();
  }

  updateNoteById(int id) async {
    DateTime now = DateTime.now();
    String datetime = DateFormat("MMMM dd, yyyy /hh:mm a").format(now);
    NoteObj note = NoteObj(
      id: id,
      title: titleController.text,
      note: noteController.text,
      creatat: datetime,
    );
    log("id" + id.toString());
    log("note" + note.toString());

    await _db.updateNotebyID(id, note.title!, note.note!, note.creatat!);
    getAllNote();
    getAllFavouriteNote();
    getAllTrashNote();
    clear();
    Get.back();
  }

  clear() {
    titleController.clear();
    noteController.clear();
  }
}
