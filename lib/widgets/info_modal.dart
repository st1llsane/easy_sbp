import 'package:flutter/material.dart';

Future<void> infoModal(
  BuildContext context, {
  required String title,
  required String description,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // title: const Text('Basic dialog title'),
        title: Text(title),
        // content: const Text(
        //   'A dialog is a type of modal window that\n'
        //   'appears in front of app content to\n'
        //   'provide critical information, or prompt\n'
        //   'for a decision to be made.',
        // ),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Disable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Enable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
