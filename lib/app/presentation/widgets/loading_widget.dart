import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: CircularProgressIndicator()),
        SizedBox(
          height: 16,
        ),
        Center(child: Text('Please, wait!')),
      ],
    );
  }
}
