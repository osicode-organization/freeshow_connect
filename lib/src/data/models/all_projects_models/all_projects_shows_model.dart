import '../../../domain/entity/all_projects_entity/all_projects_shows_entity.dart';

class AllProjectsShowsModel extends AllProjectsShowsEntity {
  const AllProjectsShowsModel({
    required super.id,
    required super.type,
    required super.name,
    required super.notes,
  });

  factory AllProjectsShowsModel.fromJson(Map<dynamic, dynamic> map) {
    return AllProjectsShowsModel(
      id: map['id'],
      type: map['type'] ?? '',
      name: map['name'] ?? '',
      notes: map['notes'] ?? '',
    );
  }
}
