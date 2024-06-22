import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oshinstar/cubits/cubits.dart';
import 'package:oshinstar/modules/profile/widgets/user_avatar.dart';

class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> user = context.watch<UserCubit>().state;
    final List<dynamic> categories = user['categories'] ?? [];
    final String categoriesText = categories.join(' · ');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UserAvatarWidget(
            src:
                "https://cdn.discordapp.com/attachments/871539767332986880/1038048692004991036/image.png?ex=6668da6e&is=666788ee&hm=8bd39f1b06f564ecdc1b70a32ae9ebfabb54e05068d239213b8b1f3cbd336000&",
            size: 75,
            showBorder: true,
            borderColor: Colors.white,
            elevation: 10,
            sizeIconPlaceHolder: 45,
            hasAvatar: false,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user['firstName'] + ' ' + user['lastName'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      categoriesText ?? '',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 1),
                Row(
                  children: [
                    const Icon(
                      Icons.location_pin,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      user["location"],
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.more_vert),
        ],
      ),
    );
  }
}
