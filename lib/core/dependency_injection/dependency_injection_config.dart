import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:info_space_app/app/data/datasources/i_iss_location_map_remote_datasource.dart';
import 'package:info_space_app/app/data/datasources/i_people_in_space_local_datasource.dart';
import 'package:info_space_app/app/data/datasources/i_people_in_space_remote_datasource.dart';
import 'package:info_space_app/app/data/repositories/iss_location_map_repository.dart';
import 'package:info_space_app/app/data/repositories/people_in_space_repository.dart';
import 'package:info_space_app/app/domain/repositories/i_iss_location_map_repository.dart';
import 'package:info_space_app/app/domain/repositories/i_people_in_space_repository.dart';
import 'package:info_space_app/app/domain/usecases/get_iss_location_map_usecase.dart';
import 'package:info_space_app/app/domain/usecases/get_peoples_in_space_usecase.dart';
import 'package:info_space_app/app/external/datasources/iss_location_map_remote_datasource.dart';
import 'package:info_space_app/app/external/datasources/people_in_space_remote_datasource.dart';
import 'package:info_space_app/app/external/http/http_client.dart';
import 'package:info_space_app/app/external/http/i_http_client.dart';
import 'package:info_space_app/app/internal/datasources/people_in_space_local_datasource.dart';
import 'package:info_space_app/app/internal/local_storage/i_local_storage.dart';
import 'package:info_space_app/app/internal/local_storage/local_storage.dart';
import 'package:info_space_app/app/presentation/pages/home/home_controller.dart';
import 'package:info_space_app/app/presentation/pages/iss_location_map/iss_location_map_controller.dart';
import 'package:info_space_app/app/presentation/pages/peoples_in_space/peoples_in_space_controller.dart';
import 'package:info_space_app/app/presentation/pages/splash/splash_controller.dart';
import 'package:info_space_app/core/network_status/i_network_status.dart';
import 'package:info_space_app/core/network_status/network_status.dart';
import 'package:info_space_app/core/routes/i_routes.dart';
import 'package:info_space_app/core/routes/routes.dart';
import 'package:info_space_app/core/routes/routes_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

void configRoutes() {
  locator.registerSingleton<RoutesConfig>(RoutesConfig());
  locator.registerLazySingleton<IRoutes>(
    () => Routes(config: locator.get<RoutesConfig>()),
  );
}

void configHttp() {
  locator.registerLazySingleton<INetworkStatus>(
    () => NetworkStatus(
      connectivity: Connectivity(),
    ),
  );
  locator.registerLazySingleton<IHttpClient>(
    () => HttpClient(
      dio: Dio(),
    ),
  );
}

void configLocalStorage() {
  locator.registerSingletonAsync<SharedPreferences>(
    () async => SharedPreferences.getInstance(),
  );

  locator.registerSingletonWithDependencies<ILocalStorage>(
    () => LocalStorage(sharedPreferences: locator.get<SharedPreferences>()),
    dependsOn: [SharedPreferences],
  );
}

void configDatasources() {
  locator.registerLazySingleton<IPeopleInSpaceLocalDatasource>(
    () => PeopleInSpaceLocalDatasource(
      localStorage: locator.get<ILocalStorage>(),
    ),
  );
  locator.registerLazySingleton<IPeopleInSpaceRemoteDatasource>(
    () => PeopleInSpaceRemoteDatasource(
      httpClient: locator.get<IHttpClient>(),
    ),
  );

  locator.registerLazySingleton<IIssLocationMapRemoteDatasource>(
    () => IssLocationMapRemoteDatasource(
      httpClient: locator.get<IHttpClient>(),
    ),
  );
}

void configRepositories() {
  locator.registerLazySingleton<IPeopleInSpaceRepository>(
    () => PeopleInSpaceRepository(
      networkStatus: locator.get<INetworkStatus>(),
      peopleInSpaceLocalDatasource:
          locator.get<IPeopleInSpaceLocalDatasource>(),
      peopleInSpaceRemoteDatasource:
          locator.get<IPeopleInSpaceRemoteDatasource>(),
    ),
  );

  locator.registerLazySingleton<IIssLocationMapRepository>(
    () => IssLocationMapRepository(
      networkStatus: locator.get<INetworkStatus>(),
      issLocationMapRemoteDatasource:
          locator.get<IIssLocationMapRemoteDatasource>(),
    ),
  );
}

void configUsecases() {
  locator.registerLazySingleton<GetPeoplesInSpaceUsecase>(
    () => GetPeoplesInSpaceUsecase(
      peoplesInSpaceRepository: locator.get<IPeopleInSpaceRepository>(),
    ),
  );

  locator.registerLazySingleton<GetIssLocationMapUsecase>(
    () => GetIssLocationMapUsecase(
      issLocationMapRepository: locator.get<IIssLocationMapRepository>(),
    ),
  );
}

void configControllers() {
  locator.registerLazySingleton<SplashController>(
    () => SplashController(
      routes: locator.get<IRoutes>(),
    ),
  );
  locator.registerLazySingleton<HomeController>(
    () => HomeController(),
  );
  locator.registerLazySingleton<PeoplesInSpaceController>(
    () => PeoplesInSpaceController(
      getPeoplesInSpaceUsecase: locator.get<GetPeoplesInSpaceUsecase>(),
    ),
  );
  locator.registerLazySingleton<IssLocationMapController>(
    () => IssLocationMapController(
      getIssLocationMapUsecase: locator.get<GetIssLocationMapUsecase>(),
    ),
  );
}

void setupLocator() {
  configRoutes();
  configHttp();
  configLocalStorage();
  configDatasources();
  configRepositories();
  configUsecases();
  configControllers();
}
