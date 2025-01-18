import 'package:flutter/material.dart';

import '../theme/theme.dart';


class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key? key,
    this.onCancel,
    required this.title,
    required this.message,
    required this.onConfirm,
  }) : super(key: key);

  final String title;
  final String message;
  final Function onConfirm;
  final Function? onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: Theme.of(context).splashColor),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      content: Text(
        message,
        style: TextStyle(color: Theme.of(context).splashColor),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(80, 50),
            textStyle: const TextStyle(fontSize: 18, color: Colors.white),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          ),
          child: const Text(
            'Cancel',
          ),
          onPressed: () {
            if (onCancel != null) {
              onCancel!();
            }
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(80, 50),
            textStyle: const TextStyle(fontSize: 18, color: Colors.white),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          ),
          child: Text(
            'YES',
          ),
          onPressed: () {
            onConfirm();
          },
        ),
      ],
    );
  }
}