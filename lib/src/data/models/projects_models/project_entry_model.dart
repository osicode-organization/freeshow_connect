import '../../../domain/entity/projects_entity/project_entry_entity.dart';

class ProjectEntryModel extends ProjectEntryEntity {
  const ProjectEntryModel({
    required super.name,
    required super.created,
    required super.parent,
    required super.shows,
  });

  factory ProjectEntryModel.fromJson(Map<dynamic, dynamic> map) {
    return ProjectEntryModel(
      name: map['name'],
      created: map['created'],
      parent: map['parent'],
      shows: map['shows'],
    );
  }
}
