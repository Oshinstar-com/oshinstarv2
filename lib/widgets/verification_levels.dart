import 'package:flutter/material.dart';

class VerificationLevels extends StatelessWidget {
  const VerificationLevels({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerificationLevel(
            level: 'Basic level',
            status: 'Not verified',
            usage: 'Basic Use of Oshinstar',
            items: [
              VerificationItem(status: 'verified', text: 'Phone number'),
              VerificationItem(status: 'pending', text: 'Email'),
            ],
            iconColor: Colors.orange,
          ),
          SizedBox(height: 20),
          VerificationLevel(
            level: 'Pro Level',
            status: 'Not verified',
            usage: 'Full use of Oshinstar',
            items: [
              VerificationItem(status: 'pending', text: 'Personal data'),
              VerificationItem(status: 'pending', text: 'Passport or ID'),
            ],
            iconColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

class VerificationLevel extends StatelessWidget {
  final String level;
  final String status;
  final String usage;
  final List<VerificationItem> items;
  final Color iconColor;

  VerificationLevel({super.key, 
    required this.level,
    required this.status,
    required this.usage,
    required this.items,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.check_circle, color: iconColor),
            SizedBox(width: 10),
            Text(
              level,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(status),
        Text(usage),
        ...items,
      ],
    );
  }
}

class VerificationItem extends StatelessWidget {
  final String status;
  final String text;

  const VerificationItem({super.key, required this.status, required this.text});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;
    switch (status) {
      case 'verified':
        icon = Icons.check;
        color = Colors.green;
        break;
      case 'pending':
      default:
        icon = Icons.pause_circle_filled;
        color = Colors.orange;
        break;
    }

    return Row(
      children: [
        Icon(icon, color: color),
        SizedBox(width: 10),
        Text(text),
      ],
    );
  }
}