import 'package:equatable/equatable.dart';

class ShowLayoutsEntity extends Equatable {
  final String name;
  final String notes;
  final List<Map<String, String>> slides;

  const ShowLayoutsEntity({
    required this.name,
    required this.notes,
    required this.slides,
  });

  @override
  List<Object?> get props => [name, notes, slides];
}
