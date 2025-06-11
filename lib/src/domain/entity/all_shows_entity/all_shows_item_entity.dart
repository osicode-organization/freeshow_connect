import 'package:equatable/equatable.dart';
import 'package:freeshow_connect/src/domain/entity/all_shows_entity/all_shows_timestamps_entity.dart';

class AllShowsItemEntity extends Equatable {
  final String name;
  final String category;
  final AllShowsTimestampsEntity timestamps;
  final Map<String, dynamic> quickAccess;
  final String origin;

  const AllShowsItemEntity({
    required this.name,
    required this.category,
    required this.timestamps,
    required this.quickAccess,
    required this.origin,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name, category, timestamps, quickAccess, origin];
}
