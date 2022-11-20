// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/view/note_detail_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchBar extends SearchDelegate {
  NoteController controller = Get.find<NoteController>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final SuggestionList = query.isEmpty
        ? controller.notes
        : controller.notes.where((keySearch) {
            return keySearch.title!
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                keySearch.content!.toLowerCase().contains(query.toLowerCase());
          }).toList();

    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        right: 10,
        left: 10,
      ),
      child: StaggeredGridView.countBuilder(
        itemCount: SuggestionList.length,
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(
                NoteDetailPage(),
                arguments: index,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black38,
                        offset: Offset(10, 10),
                        blurRadius: 15)
                  ]),
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    SuggestionList[index].title!,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    SuggestionList[index].content!,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                    maxLines: 6,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    controller.notes[index].dateTimeEdited!,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
