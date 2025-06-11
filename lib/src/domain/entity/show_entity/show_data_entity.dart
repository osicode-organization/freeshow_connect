import 'package:equatable/equatable.dart';
import 'package:freeshow_connect/src/domain/entity/show_entity/show_details_entity.dart';

class ShowDataEntity extends Equatable {
  final String action;
  final String id;
  final ShowDetailsEntity data;

  const ShowDataEntity({
    required this.action,
    required this.id,
    required this.data,
  });

  @override
  List<Object?> get props => [action, id, data];
}
