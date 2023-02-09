import 'package:info_space_repository/info_space_repository.dart';

abstract class PeoplesInSpaceState {}

class InitialPeoplesInSpaceState extends PeoplesInSpaceState {}

class SuccessPeoplesInSpaceState extends PeoplesInSpaceState {
  SuccessPeoplesInSpaceState(this.data);

  final List<PeopleInSpace> data;
}

class LoadingPeoplesInSpaceState extends PeoplesInSpaceState {}

class FailurePeoplesInSpaceState extends PeoplesInSpaceState {
  FailurePeoplesInSpaceState(this.failure);

  final Exception failure;
}
