import '../../../domain/entity/shows_entity/shows_entity.dart';

class ShowsModel extends ShowsEntity {
  const ShowsModel({
    required super.showId,
    required super.showName,
    required super.showCategory,
    required super.showCreated,
    required super.showModified,
    required super.showUsed,
    required super.showQuickAccess,
    required super.showOrigin,
  });
}
