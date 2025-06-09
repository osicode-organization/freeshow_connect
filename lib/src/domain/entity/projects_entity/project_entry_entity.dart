import 'package:equatable/equatable.dart';

class ProjectEntryEntity extends Equatable {
  final String name;
  final int created;
  final String parent;
  final List<dynamic> shows;
  final int? modified; // Optional field
  final int? used; // Optional field

  const ProjectEntryEntity({
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
