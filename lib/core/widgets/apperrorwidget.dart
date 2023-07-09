import 'package:flutter/material.dart';
import 'package:test_app/core/utils/constants.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 150,
          ),
          const SizedBox(
            height: sizedboxheight,
          ),
          Text(message)
        ],
      ),
    );
  }
}
