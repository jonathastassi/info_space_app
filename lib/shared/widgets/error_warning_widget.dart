import 'package:flutter/material.dart';

class ErrorWarningWidget extends StatelessWidget {
  const ErrorWarningWidget({
    Key? key,
    this.title = 'Error!',
    required this.onRetry,
  }) : super(key: key);

  final String title;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: 50,
        ),
        SizedBox(
          height: 16,
        ),
        Text(title),
        SizedBox(
          height: 16,
        ),
        TextButton(
          onPressed: onRetry,
          child: Text('Retry'),
        )
      ],
    );
  }
}
