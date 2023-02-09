import 'lat_lng.dart';

class IssLocationMap {
  IssLocationMap({
    required this.timestamp,
    required this.position,
  });

  final String timestamp;
  final LatLng position;

  factory IssLocationMap.fromJson(Map<String, dynamic> json) {
    return IssLocationMap(
      timestamp: json['timestamp'].toString(),
      position: LatLng(
        double.tryParse(json['iss_position']['latitude']) ?? 0,
        double.tryParse(json['iss_position']['longitude']) ?? 0,
      ),
    );
  }
}
