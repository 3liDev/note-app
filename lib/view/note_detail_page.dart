import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/widgets/alertDialog.dart';
import 'edit_note_page.dart';
import 'home_page.dart';

class NoteDetailPage extends StatelessWidget {
  final NoteController controller = Get.find();

  NoteDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int i = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
            ),
            onPressed: () {
              Get.to(
                EditNotePage(),
                arguments: i,
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
            ),
            onPressed: () {
              Get.bottomSheet(
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialogNew(
                                  contentText:
                                      "Are you sure you want to delete the note?",
                                  confirmFunction: () {
                                    controller
                                        .deleteNote(controller.notes[i].id!);
                                    Get.offAll(HomePage());
                                  },
                                  declineFunction: () {
                                    Get.back();
                                  },
                                );
                              },
                            );
                          },
                          child: Row(
                            children: const [
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.delete,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Delete",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextButton(
                          onPressed: () {
                            controller.shareNote(
                              controller.notes[i].title!,
                              controller.notes[i].content!,
                            );
                          },
                          child: Row(
                            children: const [
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.share,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Share",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 5,
                          right: 5,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Created :  " +
                                  controller.notes[i].dateTimeCreated!,
                              style: const TextStyle(
                                fontSize: 13,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Content Word Count :  " +
                                  controller.contentWordCount.toString(),
                              style: const TextStyle(
                                fontSize: 13,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Content Character Count :  " +
                                  controller.contentCharCount.toString(),
                              style: const TextStyle(
                                fontSize: 13,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              "Created by Ali Joher",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
              );
            },
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: GetBuilder<NoteController>(
        builder: (_) => Scrollbar(
          child: Container(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SelectableText(
                    controller.notes[i].title!,
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Last Edited : " + controller.notes[i].dateTimeEdited!,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SelectableText(
                    controller.notes[i].content!,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
