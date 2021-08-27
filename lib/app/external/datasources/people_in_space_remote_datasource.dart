import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:info_space_app/app/data/datasources/i_people_in_space_remote_datasource.dart';
import 'package:info_space_app/app/data/models/people_in_space_model.dart';
import 'package:info_space_app/core/errors/expections.dart';

class PeopleInSpaceRemoteDatasource implements IPeopleInSpaceRemoteDatasource {
  final Dio dio;

  PeopleInSpaceRemoteDatasource({required this.dio});

  @override
  Future<List<PeopleInSpaceModel>> getPeoplesInSpace() async {
    try {
      final response = await dio.get('http://api.open-notify.org/astros.json');

      final result = json.decode(response.data);

      if (result['message'] == 'success') {
        final listPeoples = result['people'] as List;

        return listPeoples
            .map((peoples) => PeopleInSpaceModel.fromJson(peoples))
            .toList();
      }
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }
}
