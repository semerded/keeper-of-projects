import 'package:flutter/material.dart';
import 'package:keeper_of_projects/backend/data.dart';
import 'package:keeper_of_projects/common/custom/progress_elevated_button.dart';
import 'package:keeper_of_projects/common/widgets/icon.dart';
import 'package:keeper_of_projects/common/widgets/text.dart';
import 'package:keeper_of_projects/data.dart';
import 'package:keeper_of_projects/screens/projects/project_part_view_page.dart';
import 'package:keeper_of_projects/screens/projects/widgets/project_button_info_dialog.dart';

class ProjectViewPage extends StatefulWidget {
  final Map<String, dynamic> projectData;
  const ProjectViewPage({required this.projectData, super.key});

  @override
  State<ProjectViewPage> createState() => _ProjectViewPageState();
}

class _ProjectViewPageState extends State<ProjectViewPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop(true);
        return Future<bool>.value(true);
      },
      child: Scaffold(
        backgroundColor: Pallete.bg,
        appBar: AppBar(
          backgroundColor: Pallete.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(true),
          ),
          title: Text(widget.projectData["title"]),
        ),
        body: Column(
          children: [
            Row(
              //^ priority visualtisation
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        showInfoDialog(
                          context,
                          "Project Prioirty: projects have different priorities. A project has a general priority while its project parts can have different priorities that are not linked to the general priority.",
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: projectPriorities[widget.projectData["priority"]]),
                      child: Text(
                        "priority: ${widget.projectData["priority"]}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                //^ category visualisation
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        showInfoDialog(
                          context,
                          "Project Category: The set category for this project. Categories are filterable in the project menu and tell more about a specific project.",
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallete.bg,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Pallete.text),
                        ),
                      ),
                      child: AdaptiveText("category: ${widget.projectData["category"]}"),
                    ),
                  ),
                )
              ],
            ),
            Row(
              //^ project size visualisation
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: ProgressElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallete.bg,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Pallete.text),
                        ),
                      ),
                      onPressed: () {
                        showInfoDialog(
                          context,
                          "Project Size: Shows the size of the project, the description converts a percental scale to something more readable. The background shows the percental scale.",
                        );
                      },
                      progress: () {
                        int size = widget.projectData["size"];
                        return size.toDouble() / 100;
                      }(),
                      progressColor: Pallete.primary,
                      child: Text(
                        () {
                          List<String> currentProjectSizeDescription = settingsDataContent!["funnyProjectSize"] ? projectSizeDescriptionAlternative : projectSizeDescription;
                          if (widget.projectData["size"] == 0) {
                            return currentProjectSizeDescription[0];
                          }
                          double value = ((widget.projectData["size"] - 1) / projectSizeDescriptionSubdivisionNumber) + 1;
                          return currentProjectSizeDescription[value.toInt()];
                        }(),
                        style: TextStyle(color: Pallete.text),
                      ),
                    ),
                  ),
                ),
                //^ completion visualisation
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        showInfoDialog(
                          context,
                          "Project completion, This shows how much of the project parts have been completed.",
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallete.bg,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Pallete.text),
                        ),
                      ),
                      child: AdaptiveText("category: ${widget.projectData["category"]}"),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AdaptiveText(
                widget.projectData["description"] == "" ? "No Description" : widget.projectData["description"],
                fontStyle: widget.projectData["description"] == "" ? FontStyle.italic : null,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.projectData["part"].length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> part = widget.projectData["part"][index];
                  return Card(
                    color: Pallete.topbox,
                    child: ListTile(
                      title: AdaptiveText(part["title"]),
                      subtitle: AdaptiveText(part["description"]),
                      shape: Border(
                        left: BorderSide(
                          width: 10,
                          color: projectPriorities[part["priority"]],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<bool>(
                            builder: (context) => ProjectPartViewPage(
                              part: part,
                            ),
                          ),
                        ).then((callback) {
                          if (callback != null && callback) {}
                        });
                      },
                      trailing: IconButton(
                        icon: const AdaptiveIcon(Icons.check),
                        onPressed: () {},
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
