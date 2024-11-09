import 'package:flutter/material.dart';

class ErrorWarningWidget extends StatelessWidget {
  const ErrorWarningWidget({
    super.key,
    this.title = 'Error!',
    required this.onRetry,
  });

  final String title;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          size: 50,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(title),
        const SizedBox(
          height: 16,
        ),
        TextButton(
          onPressed: onRetry,
          child: const Text('Retry'),
        )
      ],
    );
  }
}
