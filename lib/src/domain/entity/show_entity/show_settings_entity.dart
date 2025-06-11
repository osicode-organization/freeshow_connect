import 'package:equatable/equatable.dart';

class ShowSettingsEntity extends Equatable {
  final String activeLayout;
  final String template;

  const ShowSettingsEntity({
    required this.activeLayout,
    required this.template,
  });

  @override
  List<Object?> get props => [activeLayout, template];
}
