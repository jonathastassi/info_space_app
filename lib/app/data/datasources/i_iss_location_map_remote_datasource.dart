import 'package:info_space_app/app/data/models/iss_location_map_model.dart';

abstract class IIssLocationMapRemoteDatasource {
  Future<IssLocationMapModel> getIssLocation();
}
