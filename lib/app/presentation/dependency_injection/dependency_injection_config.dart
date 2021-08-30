import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:info_space_app/app/external/http/http_client.dart';
import 'package:info_space_app/app/external/http/i_http_client.dart';
import 'package:info_space_app/app/internal/local_storage/i_local_storage.dart';
import 'package:info_space_app/app/internal/local_storage/local_storage.dart';
import 'package:info_space_app/core/network_status/i_network_status.dart';
import 'package:info_space_app/core/network_status/network_status.dart';

class DependencyInjectionConfig implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ILocalStorage>(
      () => LocalStorage(
        sharedPreferences: GetStorage(),
      ),
    );
    Get.lazyPut<IHttpClient>(
      () => HttpClient(
        dio: Dio(),
      ),
    );
    Get.lazyPut<INetworkStatus>(
      () => NetworkStatus(
        connectivity: Connectivity(),
      ),
    );
  }
}
