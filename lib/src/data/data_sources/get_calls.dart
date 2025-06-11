import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/projects_models/project_data_model.dart';
import '../models/projects_models/projects_model.dart';
import '../models/shows_models/show_data_model.dart';
import '../models/shows_models/shows_model.dart';
import 'http_calls.dart';

Future<List<ShowsModel>> getShow() async {
  final Map<String, dynamic> data = {};

  final String actionId = 'get_shows';
  final String nextUrl = '$baseUrl?action=$actionId&data=${jsonEncode(data)}';

  final uri = Uri.parse(nextUrl);
  final response = await http.post(uri);

  if (response.statusCode == 200) {
    debugPrint('Successful get_shows command. Response is ${response.body}');
    final Map<String, dynamic> jsonMap = json.decode(response.body);
    return showModelList(jsonMap);
    debugPrint('Successful get_shows list is ${showModelList(jsonMap)}');
  } else if (response.statusCode == 204) {
    // Handle success with no content
    debugPrint('Get was successful, no content returned.');
  } else {
    debugPrint(
      'Failed to receive get_shows command. Status code: ${response.statusCode}',
    );
    throw Exception('Failed to get shows');
  }
  return [];
}

List<ShowsModel> showModelList(Map<String, dynamic> jsonMap) {
  final ShowDataModel showData = ShowDataModel.fromJson(jsonMap);
  return showData.data.entries.map((entry) {
    return ShowsModel(
      showId: entry.key,
      showName: entry.value.name,
      showCategory: entry.value.category,
      showCreated: DateTime.fromMillisecondsSinceEpoch(
        entry.value.timestamps.created,
      ),
      showModified: DateTime.fromMillisecondsSinceEpoch(
        entry.value.timestamps.modified,
      ),
      showUsed: DateTime.fromMillisecondsSinceEpoch(
        entry.value.timestamps.used,
      ),
      showQuickAccess: entry.value.quickAccess,
      showOrigin: entry.value.origin,
    );
  }).toList();
}

Future<List<ProjectsModel>> getProjects() async {
  final Map<String, dynamic> data = {};

  final String actionId = 'get_projects';
  final String nextUrl = '$baseUrl?action=$actionId&data=${jsonEncode(data)}';
  // debugPrint('test');

  final uri = Uri.parse(nextUrl); //baseUrl
  final response = await http.post(uri); // Encode data to JSON if provided);

  if (response.statusCode == 200) {
    // debugPrint(
    //   'Successful get_projects command. Response project is decode ${json.decode(response.body)}',
    // );
    final Map<String, dynamic> jsonMap = json.decode(response.body);

    final List<ShowsModel> allShows = await getShow();
    return projectModelList(jsonMap, allShows);
  } else if (response.statusCode == 204) {
    // Handle success with no content
    debugPrint('Get was successful, no content returned.');
  } else {
    debugPrint(
      'Failed to receive get_projects command. Status code: ${response.statusCode}',
    );
    throw Exception('Failed to get projects');
  }
  return [];
}

List<ProjectsModel> projectModelList(
  Map<String, dynamic> jsonMap,
  List<ShowsModel> allShows,
) {
  final ProjectDataModel projectData = ProjectDataModel.fromJson(jsonMap);

  List<ProjectsModel> projects = [];

  projectData.data.forEach((key, projectEntry) {
    /*debugPrint('  Name: ${projectEntry.name}');
    debugPrint(
      '  Created: ${DateTime.fromMillisecondsSinceEpoch(projectEntry.created)}',
    );
    debugPrint('  Parent: ${projectEntry.parent}');
    debugPrint('  Shows:');

    for (var show in projectEntry.shows) {
      debugPrint(
        '    - ID: ${show.id}, Type: ${show.type}, Name: ${show.name}, Notes: ${show.notes}',
      );
    }

    if (projectEntry.modified != 0) {
      debugPrint(
        '  Modified: ${DateTime.fromMillisecondsSinceEpoch(projectEntry.modified!)}',
      );
    }

    if (projectEntry.used != 0) {
      debugPrint(
        '  Used: ${DateTime.fromMillisecondsSinceEpoch(projectEntry.used!)}',
      );
    }*/

    // Extract IDs from ProjectShowsModel list
    List<String> projectShowIds =
        projectEntry.shows.map((project) => project.id).toList();
    List<ShowsModel> filteredShows =
        allShows.where((show) => projectShowIds.contains(show.showId)).toList();

    // for (var show in filteredShows) {
    //   debugPrint("${show.showId}: ${show.showName} (${show.showCategory})");
    // }

    projects.add(
      ProjectsModel(
        projectId: key,
        projectName: projectEntry.name,
        projectCreated: DateTime.fromMillisecondsSinceEpoch(
          projectEntry.created,
        ),
        projectParent: projectEntry.parent,
        projectShows: filteredShows,
        projectModified: DateTime.fromMillisecondsSinceEpoch(
          projectEntry.modified,
        ),
        projectUsed: DateTime.fromMillisecondsSinceEpoch(projectEntry.used),
      ),
    );
  });

  // debugPrint('  projects: $projects');
  return projects;
}

Future<void> getSlide(String? showId, String? slideId) async {
  final Map<String, dynamic> data = {
    "showId?": showId ?? "active",
    "slideId?": slideId,
  };

  final String actionId = 'get_slide';
  final String nextUrl = '$baseUrl?action=$actionId&data=${jsonEncode(data)}';
  // debugPrint('test');

  final uri = Uri.parse(nextUrl); //baseUrl
  final response = await http.post(uri); // Encode data to JSON if provided);

  if (response.statusCode == 200) {
    // debugPrint(
    //   'Successful get_slide command. Response get_slide is: ${json.decode(response.body)}',
    // );
    final Map<String, dynamic> jsonMap = json.decode(response.body);
  } else if (response.statusCode == 204) {
    // Handle success with no content
    debugPrint('Get was successful, no content returned.');
  } else {
    debugPrint(
      'Failed to receive get_slide command. Status code: ${response.statusCode}',
    );
    throw Exception('Failed to get_slide');
  }
}

Future<void> getSlideThumbnail(
  String? showId,
  String? layoutId,
  String? number,
) async {
  final Map<String, dynamic> data = {
    "showId?": showId,
    "layoutId?": layoutId,
    "index?": number,
  };

  final String actionId = 'get_slide_thumbnail';
  final String nextUrl = '$baseUrl?action=$actionId&data=${jsonEncode(data)}';

  final uri = Uri.parse(nextUrl); //baseUrl
  final response = await http.post(uri); // Encode data to JSON if provided);

  if (response.statusCode == 200) {
    debugPrint(
      'Successful get_slide_thumbnail command. Response get_slide_thumbnail is: ${json.decode(response.body)}',
    );
    final Map<String, dynamic> jsonMap = json.decode(response.body);
  } else if (response.statusCode == 204) {
    // Handle success with no content
    debugPrint('Get get_slide_thumbnail was successful, no content returned.');
  } else {
    debugPrint(
      'Failed to receive get_slide_thumbnail command. Status code: ${response.statusCode}',
    );
    throw Exception('Failed to get_slide_thumbnail');
  }
}
