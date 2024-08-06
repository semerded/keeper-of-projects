import 'package:flutter/material.dart';
import 'package:keeper_of_projects/common/widgets/text.dart';
import 'package:keeper_of_projects/data.dart';

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
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
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
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
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
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallete.bg,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Pallete.text),
                        ),
                      ),
                      child: Text(
                        "priority: ${widget.projectData["projectSize"]}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                //^ completion visualisation
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
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
            )
          ],
        ),
      ),
    );
  }
}
