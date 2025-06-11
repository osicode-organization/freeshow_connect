import '../../../domain/entity/all_projects_entity/all_projects_entry_entity.dart';
import 'all_projects_shows_model.dart';

class AllProjectsEntryModel extends AllProjectsEntryEntity {
  const AllProjectsEntryModel({
    required super.name,
    required super.created,
    required super.parent,
    required super.shows,
    required super.modified,
    required super.used,
  });

  factory AllProjectsEntryModel.fromJson(Map<dynamic, dynamic> map) {
    var showList =
        (map['shows'] as List<dynamic>)
            .map((show) => AllProjectsShowsModel.fromJson(show))
            .toList();
    return AllProjectsEntryModel(
      name: map['name'],
      created: map['created'],
      parent: map['parent'],
      shows: showList,
      modified: map['modified'] ?? 0,
      used: map['used'] ?? 0,
    );
  }
}
