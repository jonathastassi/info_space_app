import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:info_space_app/core/network_status/i_network_status.dart';

class NetworkStatus implements INetworkStatus {
  final Connectivity connectivity;

  NetworkStatus({required this.connectivity});

  Future<bool> hasConnection() async {
    final status = await connectivity.checkConnectivity();

    return status.index != ConnectivityResult.none.index;
  }

  @override
  Future<bool> get isConnected async => hasConnection();
}
