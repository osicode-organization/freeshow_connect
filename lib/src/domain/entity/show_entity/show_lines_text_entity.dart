import 'package:equatable/equatable.dart';

class ShowLinesTextEntity extends Equatable {
  final String value;
  final String style;
  const ShowLinesTextEntity({required this.value, required this.style});

  @override
  List<Object?> get props => [value, style];
}
