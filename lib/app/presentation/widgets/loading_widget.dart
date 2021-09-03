import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String title;
  const LoadingWidget({Key? key, this.title = 'Please, wait!'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: CircularProgressIndicator()),
          SizedBox(
            height: 16,
          ),
          Center(child: Text(title)),
        ],
      ),
    );
  }
}
