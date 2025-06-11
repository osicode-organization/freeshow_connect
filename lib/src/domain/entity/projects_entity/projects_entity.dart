import 'package:equatable/equatable.dart';
import 'package:freeshow_connect/src/domain/entity/projects_entity/project_shows_entity.dart';

import '../shows_entity/shows_entity.dart';

class ProjectsEntity extends Equatable {
  final String projectId;
  final String projectName;
  final DateTime projectCreated;
  final String projectParent;
  final List<ShowsEntity> projectShows;
  final DateTime? projectModified; // Optional field
  final DateTime? projectUsed;
  const ProjectsEntity({
    required this.projectId,
    required this.projectName,
    required this.projectCreated,
    required this.projectParent,
    required this.projectShows,
    this.projectModified,
    this.projectUsed,
  });
  @override
  List<Object?> get props => [
    projectId,
    projectName,
    projectCreated,
    projectParent,
    projectShows,
    projectModified,
    projectUsed,
  ];
}
