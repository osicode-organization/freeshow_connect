import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:freeshow_connect/src/data/models/show_models/show_data_model.dart';
import 'package:freeshow_connect/src/domain/entity/all_shows_entity/all_shows_item_entity.dart';
import 'package:freeshow_connect/src/domain/entity/show_entity/show_data_entity.dart';
import 'package:freeshow_connect/src/domain/entity/show_entity/show_details_entity.dart';
import 'package:http/http.dart' as http;

import '../../core/error/exceptions/exceptions.dart';
import '../models/all_projects_models/all_projects_data_model.dart';
import '../models/all_projects_models/all_projects_model.dart';
import '../models/all_shows_models/all_shows_data_model.dart';
import 'http_calls.dart';

/// [get_shows]
/// Gets all shows from Freeshow.
Future<List<ShowDetailsEntity>> getAllShows() async {
  final Map<String, dynamic> data = {};

  final String actionId = 'get_shows';
  final String nextUrl = '$baseUrl?action=$actionId&data=${jsonEncode(data)}';

  try {
    final uri = Uri.parse(nextUrl);
    final response = await http.post(uri);

    if (response.statusCode == 200) {
      debugPrint('Successful get_shows command. Response is ${response.body}');
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      return await allShowsModelList(jsonMap);
    } else if (response.statusCode == 204) {
      // Handle success with no content
      debugPrint('Get was successful, no content returned.');
    } else {
      debugPrint(
        'Failed to receive get_shows command. Status code: ${response.statusCode}',
      );
      throw ServerException('Failed to get shows');
    }
  } catch (e) {
    throw ServerException("Connection error"); //e.toString()
  }
  return [];
}

Future<List<ShowDetailsEntity>> allShowsModelList(
  Map<String, dynamic> jsonMap,
) async {
  final AllShowsDataModel showData = AllShowsDataModel.fromJson(jsonMap);

  if (showData.data.isEmpty) {
    throw ServerException('No shows found');
  }
  final v =
      showData.data.entries
          .map(
            (MapEntry<String, AllShowsItemEntity> entry) =>
                getSingleShow(entry.key),
          )
          .toList();
  final allShows = await Future.wait(v);
  final List<ShowDetailsEntity> allShowsDetails =
      allShows.map((item) => item.data).toList();
  return allShowsDetails;
}

/// [get_projects]
/// Gets all projects from Freeshow.
Future<List<AllProjectsModel>> getProjects() async {
  final Map<String, dynamic> data = {};

  final String actionId = 'get_projects';
  final String nextUrl = '$baseUrl?action=$actionId&data=${jsonEncode(data)}';
  // debugPrint('test');

  try {
    final uri = Uri.parse(nextUrl); //baseUrl
    final response = await http.post(uri); // Encode data to JSON if provided);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);

      final List<ShowDetailsEntity> allShows = await getAllShows();
      return allProjectsModelList(jsonMap, allShows);
    } else if (response.statusCode == 204) {
      // Handle success with no content
      debugPrint('Get was successful, no content returned.');
    } else {
      debugPrint(
        'Failed to receive get_projects command. Status code: ${response.statusCode}',
      );
      throw ServerException('Failed to get projects');
    }
  } catch (e) {
    throw ServerException("Connection error"); //e.toString()
  }
  return [];
}

List<AllProjectsModel> allProjectsModelList(
  Map<String, dynamic> jsonMap,
  List<ShowDetailsEntity> allShows,
) {
  final AllProjectsDataModel projectData = AllProjectsDataModel.fromJson(
    jsonMap,
  );

  List<AllProjectsModel> projects = [];

  if (projectData.data.isEmpty) {
    throw ServerException('No projects found');
  }

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
    List<ShowDetailsEntity> filteredShows =
        allShows.where((show) => projectShowIds.contains(show.showId)).toList();

    // for (var show in filteredShows) {
    //   debugPrint("${show.showId}: ${show.showName} (${show.showCategory})");
    // }

    projects.add(
      AllProjectsModel(
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

/// [get_show]
/// Gets details of a single show from Freeshow.
Future<ShowDataEntity> getSingleShow(String showId) async {
  final Map<String, dynamic> data = {"id": showId};

  final String actionId = 'get_show';
  final String nextUrl = '$baseUrl?action=$actionId&data=${jsonEncode(data)}';

  final uri = Uri.parse(nextUrl); //baseUrl
  final response = await http.post(uri); // Encode data to JSON if provided);

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonMap = json.decode(response.body);
    return ShowDataModel.fromJson(jsonMap);
  } else if (response.statusCode == 204) {
    debugPrint('Get was successful, no content returned.');
  } else {
    debugPrint(
      'Failed to receive get_show command. Status code: ${response.statusCode}',
    );
    throw Exception('Failed to get_show');
  }
  throw Exception('Failed to get_show');
}

Future<void> getSlide(String? showId, String? slideId) async {
  final Map<String, dynamic> data = {
    "showId?": showId ?? "active",
    "slideId?": slideId,
  };

  final String actionId = 'get_slide';
  final String nextUrl = '$baseUrl?action=$actionId&data=${jsonEncode(data)}';

  final uri = Uri.parse(nextUrl); //baseUrl
  final response = await http.post(uri); // Encode data to JSON if provided);

  if (response.statusCode == 200) {
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
