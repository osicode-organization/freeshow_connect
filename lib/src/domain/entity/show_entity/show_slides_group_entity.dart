import 'package:freeshow_connect/src/domain/entity/show_entity/show_slides_items_entity.dart';

class ShowSlidesGroupEntity {
  final String group;
  final String color;
  final Map<String, dynamic> settings;
  final String notes;
  final List<ShowSlidesItemsEntity> items;
  final String globalGroup;

  ShowSlidesGroupEntity({
    required this.group,
    required this.color,
    required this.settings,
    required this.notes,
    required this.items,
    required this.globalGroup,
  });
}
