import 'package:equatable/equatable.dart';
import 'package:freeshow_connect/src/domain/entity/show_entity/show_items_lines_entity.dart';

class ShowSlidesItemsEntity extends Equatable {
  final String type;
  final List<ShowItemsLinesEntity> lines;
  final String style;
  final String align;
  final bool auto;
  const ShowSlidesItemsEntity({
    required this.type,
    required this.lines,
    required this.style,
    required this.align,
    required this.auto,
  });

  @override
  List<Object?> get props => [type, lines, style, align, auto];
}
