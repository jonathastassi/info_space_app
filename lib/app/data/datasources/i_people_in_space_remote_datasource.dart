import 'package:info_space_app/app/data/models/people_in_space_model.dart';

abstract class IPeopleInSpaceRemoteDatasource {
  Future<List<PeopleInSpaceModel>> getPeoplesInSpace();
}
