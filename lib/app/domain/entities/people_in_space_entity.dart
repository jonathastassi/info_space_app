import 'package:equatable/equatable.dart';

class PeopleInSpaceEntity extends Equatable {
  final String name;
  final String craft;

  PeopleInSpaceEntity({
    required this.name,
    required this.craft,
  });

  @override
  List<Object> get props => [name, craft];
}
