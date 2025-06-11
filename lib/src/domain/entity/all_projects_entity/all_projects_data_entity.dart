import 'package:equatable/equatable.dart';
import 'package:freeshow_connect/src/domain/entity/all_projects_entity/all_projects_entry_entity.dart';

class AllProjectsDataEntity extends Equatable {
  final String action;
  final Map<String, AllProjectsEntryEntity> data;

  const AllProjectsDataEntity({required this.action, required this.data});

  @override
  List<Object?> get props => [action, data];
}
