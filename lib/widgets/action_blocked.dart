import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class _ActionBlockedDialog extends StatelessWidget {
  const _ActionBlockedDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          WebsafeSvg.asset('assets/oshinstar-logo-small.svg'),
          const Text('Action Blocked'),
        ],
      ),
      content: const Text(
          'Your account has been blocked from performing this action.'),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Log out'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.blue,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(4))),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Get help'),
        ),
      ],
    );
  }
}

Future<T?> showActionBlockedDialog<T>(BuildContext context) {
  return showDialog<T?>(
    context: context,
    builder: (_) => const _ActionBlockedDialog(),
  );
}
