import 'package:equatable/equatable.dart';

class ShowsEntity extends Equatable {
  final String showId;
  final String showName;
  final String showCategory;
  final DateTime showCreated;
  final DateTime showModified;
  final DateTime showUsed;
  final Map<dynamic, dynamic> showQuickAccess;
  final String showOrigin;
  const ShowsEntity({
    required this.showId,
    required this.showName,
    required this.showCategory,
    required this.showCreated,
    required this.showModified,
    required this.showUsed,
    required this.showQuickAccess,
    required this.showOrigin,
  });

  @override
  List<Object?> get props => [
    showId,
    showName,
    showCategory,
    showCreated,
    showModified,
    showUsed,
    showQuickAccess,
    showOrigin,
  ];
}
