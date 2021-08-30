import 'package:get/get.dart';
import 'package:info_space_app/app/domain/entities/people_in_space_entity.dart';
import 'package:info_space_app/app/domain/usecases/get_peoples_in_space_usecase.dart';
import 'package:info_space_app/app/presentation/utils/show_snackbar.dart';
import 'package:info_space_app/core/usecases/usecase.dart';

class PeoplesInSpaceController extends GetxController {
  var peopleInSpaceList = <PeopleInSpaceEntity>[].obs;
  var isLoading = false.obs;

  Future<void> getPeoplesInSpace() async {
    isLoading.value = true;
    GetPeoplesInSpaceUsecase controller = Get.find();

    final result = await controller.call(NoParams());

    result.fold((error) {
      showErrorSnackbar(
        title: 'Unable to display data!',
        error: error,
      );
      isLoading.value = false;
    }, (data) {
      isLoading.value = false;
      peopleInSpaceList.value = data;
    });
  }

  @override
  void onInit() {
    getPeoplesInSpace();
    super.onInit();
  }
}
