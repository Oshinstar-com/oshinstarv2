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
                const Row(
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
                SizedBox(height: 50),
                ElevatedButton(
                    onPressed: () {
                      final Map<String, dynamic> userInfo = {
                        "images": [],
                        "videos": [],
                        "tracks": [],
                        "collections": [],
                        "_id": "6667d1f063728b3a0e575a87",
                        "userId": "97ebed95-7ea5-4448-99c1-31db71e2798e",
                        "email": "jdcoding03@gmail.com",
                        "password":
                            "\$2b\$10\$4hsXRgNvkdiktbG/nwYTSuUKM3iA5I8riOnfpq6ifBTH4BfwLuMv.",
                        "firstName": "Iam",
                        "lastName": "McFock",
                        "gender": "Male",
                        "birthdate": "2011-06-11T00:00:00.000Z",
                        "phone": "8098411906",
                        "location": "",
                        "categories": ["hello-world-374", "ccdvfjategory-1"],
                        "isPhoneVerified": true,
                        "isEmailVerified": false,
                        "attempts": 1,
                        "canUpdatePhoneCode": true,
                        "accountType": "star",
                        "__v": 1
                      };
                      context.read<UserCubit>().setUserInfo(userInfo);
                    },
                    child: Text("update data"))
              ],
            ),
          ),
          const Icon(Icons.more_vert),
        ],
      ),
    );
  }
}
