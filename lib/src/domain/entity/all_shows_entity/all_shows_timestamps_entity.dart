import 'package:equatable/equatable.dart';

class AllShowsTimestampsEntity extends Equatable {
  final int created;
  final int modified;
  final int used;

  const AllShowsTimestampsEntity({
    required this.created,
    required this.modified,
    required this.used,
  });

  @override
  List<Object?> get props => [created, modified, used];
}
