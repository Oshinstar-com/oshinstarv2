import 'package:flutter/material.dart';
import 'package:oshinstar/modules/profile/widgets/user_avatar.dart';

class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatarWidget(
            src:
                "https://cdn.discordapp.com/attachments/871539767332986880/1038048692004991036/image.png?ex=6668da6e&is=666788ee&hm=8bd39f1b06f564ecdc1b70a32ae9ebfabb54e05068d239213b8b1f3cbd336000&",
            size: 75,
            showBorder: true,
            borderColor: Colors.white,
            elevation: 10,
            sizeIconPlaceHolder: 45,
            hasAvatar: false,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Jose Barranco',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Modeling · Fashion Coordinator · Musician',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                SizedBox(height: 1),
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      size: 14,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'San Francisco, United States',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.more_vert),
        ],
      ),
    );
  }
}
