import 'package:fpdart/fpdart.dart';
import 'package:freeshow_connect/src/data/data_sources/get_calls.dart';
import 'package:freeshow_connect/src/domain/entity/show_entity/show_details_entity.dart';

import '../../core/error/exceptions/exceptions.dart';
import '../../domain/domain_repository/get_calls_repository_interface.dart';
import '../../domain/entity/all_projects_entity/all_projects_entity.dart';

class GetCallsRepositoryImpl implements GetCallsRepositoryInterface {
  @override
  Future<Either<String, List<AllProjectsEntity>>> callGetProjects() async {
    try {
      final data = await getProjects();
      return data.isEmpty ? Left('Projects is empty') : Right(data);
    } on ServerException catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either<String, List<ShowDetailsEntity>>> callGetShows() async {
    try {
      final data = await getAllShows();
      return data.isEmpty ? Left('Shows is empty') : Right(data);
    } on ServerException catch (e) {
      return Left(e.message);
    }
  }
}
