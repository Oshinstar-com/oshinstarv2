import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:oshinstar/utils/themes/palette.dart';

class CurrentImage extends StatelessWidget {
  const CurrentImage({
    super.key,
    required this.imageBytes,
    required this.onRemoveImage,
    required this.onEditImage,
  });

  final Uint8List? imageBytes;
  final VoidCallback onRemoveImage;
  final VoidCallback onEditImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: imageBytes == null
          ? const Center(
              child: Text('Select a media'),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.black,
                        width: constraints.maxWidth,
                        height: 300,
                        child: Image.memory(imageBytes!),
                      ),
                      Container(
                        height: 40,
                        color: Colors.black.withOpacity(0.2),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: OshinPalette.white,
                            onPressed: onEditImage,
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            color: OshinPalette.white,
                            onPressed: onRemoveImage,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
