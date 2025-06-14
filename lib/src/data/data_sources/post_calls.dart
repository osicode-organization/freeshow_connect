import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../core/error/exceptions/exceptions.dart';

// import 'http_calls.dart';

class PostCalls {
  final String ip;
  String baseUrl;
  PostCalls({required this.ip}) : baseUrl = 'http://$ip:5505';

  /// Presentation
  /// [next_slide]
  Future<void> nextSlide() async {
    final Map<String, dynamic> data = {};
    //
    final String actionId = 'next_slide';
    await postRequest(actionId, data);
  }

  /// [previous_slide]
  Future<void> previousSlide() async {
    final Map<String, dynamic> data = {};
    //
    final String actionId = 'previous_slide';
    await postRequest(actionId, data);
  }

  /// [index_select_slide]
  Future<void> selectSlideByIndex(
    String showId,
    String layoutId,
    int index,
  ) async {
    final Map<String, dynamic> data = {
      "showId?": showId,
      "layoutId?": layoutId,
      "index": index,
    };
    //
    final String actionId = 'index_select_slide';
    await postRequest(actionId, data);
  }

  /// Projects
  /// [id_select_project]
  Future<void> selectProjectById(String id) async {
    final Map<String, dynamic> data = {"id": id};
    //
    final String actionId = 'id_select_project';
    await postRequest(actionId, data);
  }

  /// [index_select_project]
  Future<void> selectProjectByIndex(String number) async {
    final Map<String, dynamic> data = {"index": number};
    //
    final String actionId = 'index_select_project';
    await postRequest(actionId, data);
  }

  /// [name_select_project]
  Future<void> selectProjectByName(String name) async {
    final Map<String, dynamic> data = {"value": name};
    //
    final String actionId = 'name_select_project';
    await postRequest(actionId, data);
  }

  ///  Shows
  /// [name_select_show]
  /// Displays show slides on the center 'show' box.
  /// The show is selected by name.
  Future<void> selectShowByName(String name) async {
    final Map<String, dynamic> data = {"value": name};

    final String actionId = 'name_select_show';
    await postRequest(actionId, data);
  }

  /// [start_show]
  /// Displays show directly on the output from the first slide.
  /// The show is selected by the id.
  Future<void> startShow(String string) async {
    final Map<String, dynamic> data = {"id": string};
    //
    final String actionId = 'start_show';
    await postRequest(actionId, data);
  }

  /// [set_show]
  /// The show is selected by id and name.
  Future<void> setShow(String id, String name) async {
    final Map<String, dynamic> data = {"id": id, "value": name};
    //
    final String actionId = 'set_show';
    await postRequest(actionId, data);
  }

  /// Scriptures
  /// [start_scripture]
  Future<void> startScripture(String reference) async {
    debugPrint('reference');
    debugPrint(reference);
    final Map<String, dynamic> data = {
      "id": null,
      "reference": reference,
    }; //"24.1.4"
    //
    final String actionId = 'start_scripture';
    await postRequest(actionId, data);
  }

  /// [scripture_next]
  /// Moves to the next scripture
  Future<void> nextScripture() async {
    final Map<String, dynamic> data = {};
    //
    final String actionId = 'scripture_next';
    await postRequest(actionId, data);
  }

  /// [scripture_previous]
  /// Moves to the previous scripture
  Future<void> previousScripture() async {
    final Map<String, dynamic> data = {};
    //
    final String actionId = 'scripture_previous';
    await postRequest(actionId, data);
  }

  Future<void> postRequest(String actionId, Map<String, dynamic> data) async {
    final String nextUrl = '$baseUrl?action=$actionId&data=${jsonEncode(data)}';
    try {
      final uri = Uri.parse(nextUrl); //baseUrl
      final response = await http.post(
        uri,
      ); // Encode data to JSON if provided);

      if (response.statusCode == 200) {
        debugPrint(
          'Successfully sent index_select_project command. Response is ${response.body}',
        );
      } else if (response.statusCode == 204) {
        // Handle success with no content
        debugPrint('POST was successful, no content returned.');
      } else {
        debugPrint(
          'Failed to send index_select_project command. Status code: ${response.statusCode}',
        );
        throw ServerException('Failed to index_select_project');
      }
    } catch (e) {
      throw ServerException('Connection error'); //Failed with ${e.toString()}
    }
  }
}
