import 'package:get/get.dart';
import 'package:info_space_app/app/data/datasources/i_people_in_space_local_datasource.dart';
import 'package:info_space_app/app/data/datasources/i_people_in_space_remote_datasource.dart';
import 'package:info_space_app/app/data/repositories/people_in_space_repository.dart';
import 'package:info_space_app/app/domain/repositories/i_people_in_space_repository.dart';
import 'package:info_space_app/app/domain/usecases/get_peoples_in_space_usecase.dart';
import 'package:info_space_app/app/external/datasources/people_in_space_remote_datasource.dart';
import 'package:info_space_app/app/internal/datasources/people_in_space_local_datasource.dart';
import 'package:info_space_app/app/presentation/pages/home/home_controller.dart';
import 'package:info_space_app/app/presentation/pages/iss_location_map/iss_location_map_controller.dart';
import 'package:info_space_app/app/presentation/pages/peoples_in_space/peoples_in_space_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PeoplesInSpaceController>(() => PeoplesInSpaceController());
    Get.lazyPut<IssLocationMapController>(() => IssLocationMapController());

    Get.lazyPut<IPeopleInSpaceLocalDatasource>(
      () => PeopleInSpaceLocalDatasource(
        localStorage: Get.find(),
      ),
    );
    Get.lazyPut<IPeopleInSpaceRemoteDatasource>(
      () => PeopleInSpaceRemoteDatasource(
        httpClient: Get.find(),
      ),
    );
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
