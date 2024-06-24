import 'package:flutter/material.dart';

class BottomUpload extends StatelessWidget {
  const BottomUpload({
    super.key,
    required this.onUploadPressed,
  });

  final VoidCallback onUploadPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.photo),
          onPressed: onUploadPressed,
        ),
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: const Text('Upload image'),
        ),
        Container(
          width: 1,
          height: 20,
          color: Colors.blue,
        ),
        IconButton(
          icon: const Icon(Icons.arrow_upward),
          onPressed: () {},
        ),
      ],
    );
  }
}
