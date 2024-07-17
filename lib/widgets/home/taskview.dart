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
        ? Center(
            child: Text(
              "No projects found\nCreate new ideas / projects\nor recover projects from the archive",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Pallete.text,
              ),
            ),
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
