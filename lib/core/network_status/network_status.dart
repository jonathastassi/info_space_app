import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:info_space_app/core/network_status/i_network_status.dart';

class NetworkStatus implements INetworkStatus {
  final Connectivity connectivity;

  NetworkStatus({required this.connectivity});

  @override
  Future<bool> get isConnected => throw UnimplementedError();
}
