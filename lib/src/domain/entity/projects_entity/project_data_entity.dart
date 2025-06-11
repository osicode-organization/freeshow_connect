import 'package:equatable/equatable.dart';
import 'package:freeshow_connect/src/domain/entity/projects_entity/project_entry_entity.dart';

class ProjectDataEntity extends Equatable {
  final String action;
  final Map<String, ProjectEntryEntity> data;

  const ProjectDataEntity({required this.action, required this.data});

  @override
  List<Object?> get props => [action, data];
}
