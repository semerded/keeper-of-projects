import 'package:flutter/material.dart';
import 'package:keeper_of_projects/backend/data.dart';
import 'package:keeper_of_projects/data.dart';

class Taskview extends StatefulWidget {
  const Taskview({super.key});

  @override
  State<Taskview> createState() => _TaskviewState();
}

class _TaskviewState extends State<Taskview> {
  @override
  Widget build(BuildContext context) {
    return userDataContent!["projects"].length == 0
        ? const Center(
            child: Text("No projects found\nCreate new ideas or projects or recover projects from the archive"),
          )
        : ListView.builder(
            itemCount: userDataContent!["projects"].length,
            itemBuilder: (context, index) {
              return Card(
                color: Pallete.box,
                elevation: 2,
                child: ListTile(
                  textColor: Pallete.text,
                  title: Text("task"),
                ),
              );
            },
          );
  }
}
