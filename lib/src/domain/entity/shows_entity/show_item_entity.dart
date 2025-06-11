import 'package:equatable/equatable.dart';
import 'package:freeshow_connect/src/domain/entity/shows_entity/timestamps_entity.dart';

class ShowItemEntity extends Equatable {
  final String name;
  final String category;
  final TimestampsEntity timestamps;
  final Map<String, dynamic> quickAccess;
  final String origin;

  const ShowItemEntity({
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
