import 'package:flutter/material.dart';

class ManageAddressesModal extends StatelessWidget {
  const ManageAddressesModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Expanded(
                  child: Text(
                    'Manage Addresses',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(height: 1),
            const SizedBox(height: 16),
            // No Addresses Message
            const Text(
              "You don't have any address added",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            // Add Address Option
            ListTile(
              leading: const Icon(Icons.add),
              title: TextButton(
                onPressed: () {
                  // Action for adding address
                },
                child: const Text(
                  'Add address',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}