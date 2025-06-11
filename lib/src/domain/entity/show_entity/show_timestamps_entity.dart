import 'package:equatable/equatable.dart';

class ShowTimestampsEntity extends Equatable {
  final int created;
  final int modified;
  final int used;

  const ShowTimestampsEntity({
    required this.created,
    required this.modified,
    required this.used,
  });

  @override
  List<Object?> get props => [created, modified, used];
}
