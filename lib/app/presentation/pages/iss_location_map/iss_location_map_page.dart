import 'package:flutter/material.dart';

class IssLocationMapPage extends StatelessWidget {
  static String route = '/iss-location-map';

  const IssLocationMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ISS Location'),
      ),
    );
  }
}
