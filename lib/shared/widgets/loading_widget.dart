import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String title;
  const LoadingWidget({
    Key? key,
    this.title = 'Please, wait!',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(
          height: 16,
        ),
        Text(title),
      ],
    );
  }
}
