import 'package:flutter/material.dart';
import 'package:oshinstar/modules/profile/widgets/custom_loader.dart';

class ProfileLoaders extends StatelessWidget {
  final List<Map<String, dynamic>> loaders;

  const ProfileLoaders({super.key, required this.loaders});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        CustomProgressLoader(
          currentValue: loaders[0]['value'],
          icon: Icons.edit,
          label: 'Information',
          color: Colors.black,
        ),
        const SizedBox(),
        CustomProgressLoader(
          currentValue: loaders[1]['value'],
          icon: Icons.people,
          label: 'Community',
          color: Colors.green,
        ),
        const SizedBox(),
        CustomProgressLoader(
          currentValue: loaders[2]['value'],
          icon: Icons.trending_up,
          label: 'Popularity',
          color: Colors.orange,
        ),
        const SizedBox(),
      ],
    );
  }
}
