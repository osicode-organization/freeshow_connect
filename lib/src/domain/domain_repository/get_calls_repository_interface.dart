import 'package:fpdart/fpdart.dart';

import '../entity/all_projects_entity/all_projects_entity.dart';
import '../entity/show_entity/show_details_entity.dart';

abstract class GetCallsRepositoryInterface {
  Future<Either<String, List<AllProjectsEntity>>> callGetProjects();
  Future<Either<String, List<ShowDetailsEntity>>> callGetShows();
}
