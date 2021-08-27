import 'package:info_space_app/app/domain/entities/people_in_space_entity.dart';

class PeopleInSpaceModel extends PeopleInSpaceEntity {
  PeopleInSpaceModel({
    required String name,
    required String craft,
  }) : super(
          name: name,
          craft: craft,
        );

  factory PeopleInSpaceModel.fromJson(Map<String, dynamic> json) {
    return PeopleInSpaceModel(
      name: json['name'],
      craft: json['craft'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'craft': craft,
    };
  }
}
