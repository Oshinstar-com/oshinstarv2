import 'package:flutter/material.dart';

class OriginalWork extends StatelessWidget {
  const OriginalWork({super.key, required this.onChanged});

  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: false,
          onChanged: onChanged,
        ),
        const Expanded(
          child: Text(
            'This is my original work, or I have permission to post this image',
          ),
        ),
      ],
    );
  }
}
