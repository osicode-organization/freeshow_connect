import 'package:equatable/equatable.dart';

import '../../../data/models/projects_models/project_shows_model.dart';

class ProjectsEntity extends Equatable {
  final String name;
  final DateTime created;
  final String parent;
  final List<ProjectShowsModel> shows;
  final DateTime? modified; // Optional field
  final DateTime? used;
  const ProjectsEntity({
    required this.name,
    required this.created,
    required this.parent,
    required this.shows,
    this.modified,
    this.used,
  });
  @override
  List<Object?> get props => [name, created, parent, shows, modified, used];
}
