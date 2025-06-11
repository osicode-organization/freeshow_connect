import 'package:freeshow_connect/src/data/models/projects_models/project_shows_model.dart';

import '../../../domain/entity/projects_entity/project_entry_entity.dart';

class ProjectEntryModel extends ProjectEntryEntity {
  const ProjectEntryModel({
    required super.name,
    required super.created,
    required super.parent,
    required super.shows,
    required super.modified,
    required super.used,
  });

  factory ProjectEntryModel.fromJson(Map<dynamic, dynamic> map) {
    var showList =
        (map['shows'] as List<dynamic>)
            .map((show) => ProjectShowsModel.fromJson(show))
            .toList();
    return ProjectEntryModel(
      name: map['name'],
      created: map['created'],
      parent: map['parent'],
      shows: showList,
      modified: map['modified'] ?? 0,
      used: map['used'] ?? 0,
    );
  }
}
