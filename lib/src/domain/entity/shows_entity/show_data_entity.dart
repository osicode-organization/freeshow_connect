import 'package:equatable/equatable.dart';
import 'package:freeshow_connect/src/domain/entity/shows_entity/show_item_entity.dart';

class ShowDataEntity extends Equatable {
  final String action;
  final Map<String, ShowItemEntity> data;

  const ShowDataEntity({required this.action, required this.data});

  @override
  List<Object?> get props => [action, data];
}
