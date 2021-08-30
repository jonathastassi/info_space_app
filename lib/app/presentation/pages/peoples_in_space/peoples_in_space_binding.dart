import 'package:get/get.dart';
import 'package:info_space_app/app/data/repositories/people_in_space_repository.dart';
import 'package:info_space_app/app/domain/repositories/i_people_in_space_repository.dart';
import 'package:info_space_app/app/domain/usecases/get_peoples_in_space_usecase.dart';

class PeoplesInSpaceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IPeopleInSpaceRepository>(
      () => PeopleInSpaceRepository(
        networkStatus: Get.find(),
        peopleInSpaceLocalDatasource: Get.find(),
        peopleInSpaceRemoteDatasource: Get.find(),
      ),
    );
    Get.lazyPut<GetPeoplesInSpaceUsecase>(
      () => GetPeoplesInSpaceUsecase(
        peoplesInSpaceRepository: Get.find(),
      ),
    );
  }
}
