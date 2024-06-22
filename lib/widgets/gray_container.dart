import 'package:flutter/material.dart';

class GrayContainer extends StatelessWidget {
  final String? title;

  const GrayContainer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.grey[300],
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [Text(title!)],
      ),
    );
  }
}
