import 'package:equatable/equatable.dart';
import 'package:info_space_app/app/domain/entities/posititon_entity.dart';

class IssLocationMapEntity extends Equatable {
  final String timestamp;
  final PositionEntity position;

  IssLocationMapEntity({
    required this.timestamp,
    required this.position,
  });

  @override
  List<Object> get props => [timestamp, position];
}
