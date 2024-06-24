import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:oshinstar/utils/themes/palette.dart';

class UploadedImages extends StatelessWidget {
  const UploadedImages({
    super.key,
    required this.img,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<Uint8List> img;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: img.length,
        itemBuilder: (context, index) {
          final borderRadius = BorderRadius.circular(20); // Image border
          return GestureDetector(
            onTap: () => onTap(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(2), // Border width
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? OshinPalette.blue
                      : Colors.transparent,
                  borderRadius: borderRadius,
                ),
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(32),
                    child: Image.memory(
                      img[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
