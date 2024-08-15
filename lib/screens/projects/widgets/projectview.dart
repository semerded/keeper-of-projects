import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:keeper_of_projects/backend/data.dart';
import 'package:keeper_of_projects/backend/google_api/save_file.dart';
import 'package:keeper_of_projects/common/enum/page_callback.dart';
import 'package:keeper_of_projects/common/functions/calculate_completion.dart';
import 'package:keeper_of_projects/common/widgets/text.dart';
import 'package:keeper_of_projects/data.dart';
import 'package:keeper_of_projects/screens/projects/view_project_page.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:keeper_of_projects/common/custom/custom_one_border_painter.dart';

class ProjectView extends StatefulWidget {
  final List content;
  const ProjectView({super.key, required this.content});

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  @override
  Widget build(BuildContext context) {
    return widget.content.isEmpty
        ? Center(
            child: AdaptiveText(
              "No projects found\nCreate new ideas / projects\nor recover projects from the archive",
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          )
        : ListView.builder(
            itemCount: widget.content.length,
            itemBuilder: (context, index) {
              Map project = widget.content[index];
              double projectCompletion = calculateCompletion(project["part"]);
              return Card(
                shape: Border(
                  left: BorderSide(
                    width: 10,
                    color: projectPriorities[project["priority"]],
                  ),
                ),
                color: Palette.box,
                elevation: 2,
                child: CustomPaint(
                  painter: settingsDataContent!["showProjectSize"]
                      ? OneSideProgressBorderPainter(
                          color: Palette.primary,
                          progress: project["size"] == null ? 0 : project["size"] / 100,
                          strokeWidth: 3.0,
                          side: borderSide.bottom,
                        )
                      : null,
                  child: ListTile(
                    textColor: Palette.text,
                    title: AdaptiveText(
                      project["title"],
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    subtitle: Text(
                      project["description"],
                      style: TextStyle(
                        color: Palette.subtext,
                        fontSize: 13,
                      ),
                    ),
                    onTap: () => setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute<PageCallback>(
                          builder: (context) => ProjectViewPage(
                            index: index,
                            projectData: project,
                          ),
                        ),
                      ).then((callback) async {
                        if (callback != null) {
                          if (callback == PageCallback.setState || callback == PageCallback.setStateAndSync) {
                            setState(() {});
                            if (callback == PageCallback.setStateAndSync) {
                              await saveFile(projectsFileData!.id!, jsonEncode(projectsDataContent));
                            }
                          }
                        }
                      });
                    }),
                    trailing: CircularPercentIndicator(
                      radius: 25,
                      animation: true,
                      percent: projectCompletion,
                      progressColor: Colors.green,
                      center: AdaptiveText("${(projectCompletion * 100).toInt()}%"),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
