import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/projects_models/project_data_model.dart';
import '../models/projects_models/project_entry_model.dart';
import '../models/projects_models/project_shows_model.dart';
import '../models/projects_models/projects_model.dart';
import 'http_calls.dart';

Future<void> getShow() async {
  final Map<String, dynamic> data = {};

  final String actionId = 'get_shows';
  final String nextUrl = '$baseUrl?action=$actionId&data=${jsonEncode(data)}';
  // debugPrint('test');

  final uri = Uri.parse(nextUrl); //baseUrl
  final response = await http.post(uri); // Encode data to JSON if provided);

  if (response.statusCode == 200) {
    debugPrint('Successful get_shows command. Response is ${response.body}');
  } else if (response.statusCode == 204) {
    // Handle success with no content
    debugPrint('Get was successful, no content returned.');
  } else {
    debugPrint(
      'Failed to receive get_shows command. Status code: ${response.statusCode}',
    );
    throw Exception('Failed to get shows');
  }
}

Future<void> getProjects() async {
  final Map<String, dynamic> data = {};

  final String actionId = 'get_projects';
  final String nextUrl = '$baseUrl?action=$actionId&data=${jsonEncode(data)}';
  // debugPrint('test');

  final uri = Uri.parse(nextUrl); //baseUrl
  final response = await http.post(uri); // Encode data to JSON if provided);

  if (response.statusCode == 200) {
    // debugPrint(
    //   'Successful get_projects command. Response is decode ${json.decode(response.body)}',
    // );
    final Map<String, dynamic> jsonMap = json.decode(response.body);
    printProjects(jsonMap);
  } else if (response.statusCode == 204) {
    // Handle success with no content
    debugPrint('Get was successful, no content returned.');
  } else {
    debugPrint(
      'Failed to receive get_projects command. Status code: ${response.statusCode}',
    );
    throw Exception('Failed to get projects');
  }
}

printProjects(Map<String, dynamic> jsonMap) {
  final ProjectDataModel projectData = ProjectDataModel.fromJson(jsonMap);

  // Now you can access your data:
  print('Action: ${projectData.action}');
  print('Number of projects: ${projectData.data.length}');

  List<ProjectsModel> projects = [];

  projectData.data.forEach((key, projectEntry) {
    debugPrint('\nProject Key: $key');
    final ProjectEntryModel projectDataEntry = ProjectEntryModel.fromJson(
      projectEntry,
    );

    /*debugPrint('  Name: ${projectDataEntry.name}');
    debugPrint(
      '  Created: ${DateTime.fromMillisecondsSinceEpoch(projectDataEntry.created)}',
    );
    debugPrint('  Parent: ${projectDataEntry.parent}');
    debugPrint('  Shows:');*/

    List<ProjectShowsModel> projectShows = [];
    for (var show in projectDataEntry.shows) {
      final ProjectShowsModel projectDataEntryShow = ProjectShowsModel.fromJson(
        show,
      );
      /*debugPrint(
        '    - ID: ${projectDataEntryShow.id}, Type: ${projectDataEntryShow.type ?? ''}, Name: ${projectDataEntryShow.name ?? ''}',
      );*/
      projectShows.add(projectDataEntryShow);
    }

    if (projectDataEntry.modified != null) {
      /*debugPrint(
        '  Modified: ${DateTime.fromMillisecondsSinceEpoch(projectDataEntry.modified!)}',
      );*/
    }

    if (projectDataEntry.used != null) {
      /*debugPrint(
        '  Used: ${DateTime.fromMillisecondsSinceEpoch(projectDataEntry.used!)}',
      );*/
    }

    projects.add(
      ProjectsModel(
        name: projectDataEntry.name,
        created: DateTime.fromMillisecondsSinceEpoch(projectDataEntry.created),
        parent: projectDataEntry.parent,
        shows: projectShows,
        modified: DateTime.fromMillisecondsSinceEpoch(
          projectDataEntry.modified ?? 0,
        ),
        used: DateTime.fromMillisecondsSinceEpoch(projectDataEntry.used ?? 0),
      ),
    );
  });
  debugPrint('  projects: $projects');
}
