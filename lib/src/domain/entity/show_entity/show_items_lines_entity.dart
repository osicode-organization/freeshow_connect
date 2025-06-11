import 'package:equatable/equatable.dart';
import 'package:freeshow_connect/src/domain/entity/show_entity/show_lines_text_entity.dart';

class ShowItemsLinesEntity extends Equatable {
  final String align;
  final List<ShowLinesTextEntity> text;
  const ShowItemsLinesEntity({required this.align, required this.text});

  @override
  List<Object?> get props => [align, text];
}
