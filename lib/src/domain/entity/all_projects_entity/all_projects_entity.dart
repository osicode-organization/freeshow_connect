import 'package:equatable/equatable.dart';
import 'package:freeshow_connect/src/domain/entity/show_entity/show_details_entity.dart';

class AllProjectsEntity extends Equatable {
  final String projectId;
  final String projectName;
  final DateTime projectCreated;
  final String projectParent;
  final List<ShowDetailsEntity> projectShows;
  final DateTime? projectModified; // Optional field
  final DateTime? projectUsed;
  const AllProjectsEntity({
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
