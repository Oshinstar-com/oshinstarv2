import 'package:flutter/material.dart';

class ConfirmIdentityModal extends StatelessWidget {
  const ConfirmIdentityModal({Key? key}) : super(key: key);

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
                    'Confirm Your Identity',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline),
                  onPressed: () {
                    // Action for info button
                  },
                ),
              ],
            ),
            const Divider(height: 1),
            const SizedBox(height: 16),
            // Instructions
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Verify your photo ID',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Make sure the ID document clearly show your name, picture and birthday.\n\n'
              'Once we\'ve verified your identity, we\'ll permanently delete the copy of your ID within 30 days. '
              'If you have any problems, please contact OshinStar support.\n\n'
              'After this step, you\'ll unlock all the features of your account and you\'ll be ready to start earn money.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'What type of ID you want to use?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            const SizedBox(height: 16),
            // ID Options
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.credit_card),
                  title: const Text('Card ID'),
                  trailing: const Icon(Icons.add),
                  onTap: () {
                    // Action for Card ID
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text('Passport'),
                  trailing: const Icon(Icons.add),
                  onTap: () {
                    // Action for Passport
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}