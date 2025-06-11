import 'package:equatable/equatable.dart';
import 'package:freeshow_connect/src/domain/entity/projects_entity/project_shows_entity.dart';

class ProjectEntryEntity extends Equatable {
  final String name;
  final int created;
  final String parent;
  final List<ProjectShowsEntity> shows;
  final int modified; // Optional field
  final int used; // Optional field

  const ProjectEntryEntity({
    required this.name,
    required this.created,
    required this.parent,
    required this.shows,
    required this.modified,
    required this.used,
  });

  @override
  List<Object?> get props => [name, created, parent, shows, modified, used];
}
