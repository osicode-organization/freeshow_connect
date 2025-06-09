import 'package:equatable/equatable.dart';

class ProjectDataEntity extends Equatable {
  final String action;
  final Map<String, dynamic> data;

  const ProjectDataEntity({required this.action, required this.data});

  @override
  List<Object?> get props => [action, data];
}
