import 'package:info_space_app/app/data/models/people_in_space_model.dart';

abstract class IPeopleInSpaceLocalDatasource {
  Future<List<PeopleInSpaceModel>> getLastPeoplesInSpace();
  Future<void> cacheLastPeoplesInSpace(List<PeopleInSpaceModel> peoplesinSpace);
}
