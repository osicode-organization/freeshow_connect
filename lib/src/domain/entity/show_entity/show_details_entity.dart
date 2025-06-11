import 'package:equatable/equatable.dart';
import 'package:freeshow_connect/src/domain/entity/show_entity/show_layouts_entity.dart';
import 'package:freeshow_connect/src/domain/entity/show_entity/show_settings_entity.dart';
import 'package:freeshow_connect/src/domain/entity/show_entity/show_slides_group_entity.dart';
import 'package:freeshow_connect/src/domain/entity/show_entity/show_timestamps_entity.dart';

class ShowDetailsEntity extends Equatable {
  final String name;
  final String origin;
  final bool private;
  final String category;
  final ShowSettingsEntity settings;
  final ShowTimestampsEntity timestamps;
  final Map<String, dynamic> quickAccess;
  final Map<String, dynamic> meta;
  final Map<String, ShowSlidesGroupEntity> slides;
  final Map<String, ShowLayoutsEntity> layouts;
  final Map<String, dynamic> media;
  final String showId;
  const ShowDetailsEntity({
    required this.name,
    required this.origin,
    required this.private,
    required this.category,
    required this.settings,
    required this.timestamps,
    required this.quickAccess,
    required this.meta,
    required this.slides,
    required this.layouts,
    required this.media,
    required this.showId,
  });

  @override
  List<Object?> get props => [
    name,
    origin,
    private,
    category,
    settings,
    timestamps,
    quickAccess,
    meta,
    slides,
    layouts,
    media,
    showId,
  ];
}
