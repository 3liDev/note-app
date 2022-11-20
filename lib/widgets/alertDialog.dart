// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AlertDialogNew extends StatelessWidget {
  final String? contentText;
  final VoidCallback? confirmFunction;
  final VoidCallback? declineFunction;

  const AlertDialogNew(
      {Key? key, this.contentText, this.confirmFunction, this.declineFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(contentText!),
      actions: [
        TextButton(onPressed: confirmFunction, child: const Text("Yes")),
        TextButton(onPressed: declineFunction, child: const Text("No")),
      ],
    );
  }
}
