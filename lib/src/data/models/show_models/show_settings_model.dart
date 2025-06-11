import '../../../domain/entity/show_entity/show_settings_entity.dart';

class ShowSettingsModel extends ShowSettingsEntity {
  const ShowSettingsModel({
    required super.activeLayout,
    required super.template,
  });

  factory ShowSettingsModel.fromJson(Map<String, dynamic> json) {
    return ShowSettingsModel(
      activeLayout: json['activeLayout'],
      template: json['template'],
    );
  }
}
