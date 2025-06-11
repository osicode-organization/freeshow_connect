import 'package:equatable/equatable.dart';

class AllProjectsShowsEntity extends Equatable {
  final String id;
  final String type; // Optional field
  final String name; // Optional field
  final String notes; // Optional field

  const AllProjectsShowsEntity({
    required this.id,
    required this.type,
    required this.name,
    required this.notes,
  });

  @override
  List<Object?> get props => [id, type, name, notes];
}
