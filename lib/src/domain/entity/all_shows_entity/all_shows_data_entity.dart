import 'package:equatable/equatable.dart';
import 'package:freeshow_connect/src/domain/entity/all_shows_entity/all_shows_item_entity.dart';

class AllShowsDataEntity extends Equatable {
  final String action;
  final Map<String, AllShowsItemEntity> data;

  const AllShowsDataEntity({required this.action, required this.data});

  @override
  List<Object?> get props => [action, data];
}
