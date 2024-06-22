import 'package:flutter/material.dart';

class PhoneNumbersModal extends StatefulWidget {
  const PhoneNumbersModal({Key? key}) : super(key: key);

  @override
  _PhoneNumbersModalState createState() => _PhoneNumbersModalState();
}

class _PhoneNumbersModalState extends State<PhoneNumbersModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Expanded(
                  child: Text(
                    'Phone numbers',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Verified phone number
          ListTile(
            leading: const Icon(Icons.check_circle, color: Colors.green),
            title: const Text('+18098411906', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('Primary Number'),
            trailing: Icon(Icons.lock, color: Colors.grey[600]),
          ),
          const Divider(height: 1),
          // Add phone number option
          ListTile(
            leading: const Icon(Icons.add),
            title: TextButton(
              onPressed: () {
                // Action for adding phone number
              },
              child: const Text('Add Phone Number', style: TextStyle(color: Colors.blue)),
            ),
          ),
        ],
      ),
    );
  }
}
