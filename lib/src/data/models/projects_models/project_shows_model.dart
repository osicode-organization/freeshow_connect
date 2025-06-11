import '../../../domain/entity/projects_entity/project_shows_entity.dart';

class ProjectShowsModel extends ProjectShowsEntity {
  const ProjectShowsModel({
    required super.id,
    required super.type,
    required super.name,
    required super.notes,
  });

  factory ProjectShowsModel.fromJson(Map<dynamic, dynamic> map) {
    return ProjectShowsModel(
      id: map['id'],
      type: map['type'] ?? '',
      name: map['name'] ?? '',
      notes: map['notes'] ?? '',
    );
  }
}
