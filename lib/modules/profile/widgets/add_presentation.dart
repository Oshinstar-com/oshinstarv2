import 'package:flutter/material.dart';
import 'package:oshinstar/utils/themes/palette.dart';

class AddPresentation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add),
            SizedBox(width: 5),
            Text(
              "Add Presentation",
              style: TextStyle(color: OshinPalette.blue),
            )
          ],
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.all(8.0), // Add padding to the text
          child: Text(
            "Write a brief summary of your skills, strengths, passions and key experiences.",
            textAlign: TextAlign.center,
            style: TextStyle(color: OshinPalette.grey),
          ),
        ),
      ],
    );
  }
}
