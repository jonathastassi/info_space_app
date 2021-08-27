import 'dart:convert';

import 'package:info_space_app/app/data/datasources/i_people_in_space_local_datasource.dart';
import 'package:info_space_app/app/data/models/people_in_space_model.dart';
import 'package:info_space_app/app/internal/local_storage/i_local_storage.dart';
import 'package:info_space_app/core/errors/expections.dart';

const CACHED_PEOPLES_IN_SPACE = 'CACHED_PEOPLES_IN_SPACE';

class PeopleInSpaceLocalDatasource implements IPeopleInSpaceLocalDatasource {
  final ILocalStorage localStorage;

  PeopleInSpaceLocalDatasource({required this.localStorage});

  @override
  Future<void> cacheLastPeoplesInSpace(
      List<PeopleInSpaceModel> peoplesinSpace) async {
    try {
      final jsonList = json.encode(peoplesinSpace);
      final result =
          await localStorage.setString(CACHED_PEOPLES_IN_SPACE, jsonList);

      if (!result) {
        throw CacheException();
      }
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<List<PeopleInSpaceModel>> getLastPeoplesInSpace() async {
    try {
      final jsonList =
          json.decode(localStorage.getString(CACHED_PEOPLES_IN_SPACE) ?? '[]')
              as List;

      final list = jsonList
          .map((people) => PeopleInSpaceModel.fromJson(people))
          .toList();

      return list;
    } catch (_) {
      throw CacheException();
    }
  }
}
