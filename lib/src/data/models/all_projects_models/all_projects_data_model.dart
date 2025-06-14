import '../../../domain/entity/all_projects_entity/all_projects_data_entity.dart';
import 'all_projects_entry_model.dart';

class AllProjectsDataModel extends AllProjectsDataEntity {
  const AllProjectsDataModel({required super.action, required super.data});

  factory AllProjectsDataModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> mapsData =
        json['data'] is Map
            ? Map<String, dynamic>.from(json['data'] ?? {})
            : {};
    final dataMap =
        mapsData.isNotEmpty
            ? mapsData.map(
              (key, value) =>
                  MapEntry(key, AllProjectsEntryModel.fromJson(value)),
            )
            : <String, AllProjectsEntryModel>{};
    // final dataMap = (json['data'] as Map<String, dynamic>).map(
    //   (key, value) => MapEntry(key, AllProjectsEntryModel.fromJson(value)),
    // );
    return AllProjectsDataModel(action: json['action'], data: dataMap);
  }
}
