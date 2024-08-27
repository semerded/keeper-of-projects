import 'package:deepcopy/deepcopy.dart';
import 'package:flutter/material.dart';
import 'package:keeper_of_projects/common/widgets/add_textfield/description.dart';
import 'package:keeper_of_projects/common/widgets/add_textfield/title.dart';
import 'package:keeper_of_projects/common/widgets/text.dart';
import 'package:keeper_of_projects/data.dart';

Future editTask(BuildContext context, Map initTask) {
  Map editedTask = Map.from(initTask.deepcopy());

  bool validTitle = initTask.length >= 2;
  String ddb_priority_value = projectPriorities.keys.first;

  final TextEditingController descriptionController = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: AdaptiveText("add a subtask"),
          backgroundColor: Palette.bg,
          content: Stack(
            children: [
              Form(
                child: Column(
                  children: [
                    TitleTextField(
                      initialValue: editedTask["title"],
                      onChanged: (value) {
                        setState(
                          () {
                            validTitle = value.length >= 2;
                            editedTask["title"] = value;
                          },
                        );
                      },
                      hintText: "Add a title for your task",
                    ),
                    DescriptionTextField(
                      initialValue: editedTask["description"],
                      onChanged: (value) {
                        setState(
                          () {
                            editedTask["description"] = value;
                          },
                        );
                      },
                      helperText: validTitle && descriptionController.text.isEmpty ? "Try to add a description" : null,
                      controller: descriptionController,
                      hintText: "Add a description for your task",
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        color: Palette.box,
                        child: DropdownButton<String>(
                          padding: const EdgeInsets.only(left: 7, right: 7),
                          elevation: 15,
                          isExpanded: true,
                          dropdownColor: Palette.topbox,
                          value: ddb_priority_value,
                          items: projectPriorities.keys.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Row(
                                children: [
                                  Container(width: 30, height: 30, decoration: BoxDecoration(color: projectPriorities[value], shape: BoxShape.circle)),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: AdaptiveText(
                                      value,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              editedTask["priority"] = ddb_priority_value = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, null);
              },
              child: AdaptiveText("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (validTitle) {
                  Navigator.pop(context, editedTask);
                }
              },
              child: Text("Save", style: TextStyle(color: validTitle ? Palette.primary : Palette.subtext)),
            ),
          ],
        ),
      );
    },
  );
}
