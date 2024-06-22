import 'dart:io';

import 'package:flutter/material.dart';

class CustomizeImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: const Text('Customize Image'),
      ),
      body: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: 'Add Title',
              counterText: '0',
            ),
          ),
          Row(
            children: [
              Switch(value: false, onChanged: (newValue) {
                debugPrint('Switch value: $newValue');
              }),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {},
              ),
            ],
          ),
          Container(
            color: Colors.grey[350],
            child: Image.file(
              File('path/to/image'),
            ),
          ),
        ],
      )
    );
  }
}
