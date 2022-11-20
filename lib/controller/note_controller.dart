import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_app/helper/database_services/database_helper.dart';
import 'package:note_app/models/note_model.dart';
import 'package:share/share.dart';
import 'package:string_stats/string_stats.dart';

class NoteController extends GetxController {
  var titleController = TextEditingController();
  var contentController = TextEditingController();

  var notes = <Note>[];

  int contentWordCount = 0;
  int contentCharCount = 0;

  @override
  void onInit() {
    getAllNotes();
    super.onInit();
  }

  bool isEmpty() {
    if (notes.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void addNoteToDatabase() async {
    String title = titleController.text;
    String content = contentController.text;

    if (title.isBlank!) {
      title = "بدون عنوان";
    }
    Note note = Note(
        title: title,
        content: content,
        dateTimeEdited:
            DateFormat("MMM dd yyy HH:mm:ss").format(DateTime.now()),
        dateTimeCreated:
            DateFormat("MMM dd yyy HH:mm:ss").format(DateTime.now()));

    await DatabaseHelper.instance.addNote(note);

    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);

    titleController.text = "";
    contentController.text = "";

    getAllNotes();
    Get.back();
  }

  void deleteNote(int id) async {
    Note note = Note(id: id);
    await DatabaseHelper.instance.deleteNote(note);
    getAllNotes();
  }

  void deleteAllNotes() async {
    await DatabaseHelper.instance.deleteAllNotes();
    getAllNotes();
  }

  void updateNote(int id, String dateTimeCeated) async {
    final title = titleController.text;
    final content = contentController.text;

    Note note = Note(
      id: id,
      title: title,
      content: content,
      dateTimeCreated: dateTimeCeated,
      dateTimeEdited: DateFormat("MMM dd yyy HH:mm:ss").format(DateTime.now()),
    );

    await DatabaseHelper.instance.updateNote(note);

    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);

    titleController.text = '';
    contentController.text = "";

    getAllNotes();
    Get.back();
  }

  void getAllNotes() async {
    notes = await DatabaseHelper.instance.getNoteList();
    update();
  }

  void shareNote(String title, String content) {
    Share.share("""
$title
$content
created by ali joher
""");
  }
}
