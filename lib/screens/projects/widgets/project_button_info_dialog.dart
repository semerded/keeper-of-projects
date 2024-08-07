import 'package:flutter/material.dart';
import 'package:keeper_of_projects/common/widgets/text.dart';
import 'package:keeper_of_projects/data.dart';

void showInfoDialog(BuildContext context, String info) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Pallete.box,
        title: AdaptiveText(info),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Close",
              style: TextStyle(color: Pallete.primary),
            ),
          )
        ],
      );
    },
  );
}
