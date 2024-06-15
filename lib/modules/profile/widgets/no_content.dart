import 'package:flutter/material.dart';
import 'package:oshinstar/utils/themes/palette.dart';

class NoContentWidget extends StatelessWidget {
  final String message;
  final String buttonText;

  const NoContentWidget({Key? key, required this.message, required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: OshinPalette.blue, // Button color
              ),
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
