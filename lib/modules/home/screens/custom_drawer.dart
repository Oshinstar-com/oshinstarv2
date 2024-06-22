import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:oshinstar/cubits/cubits.dart';
import 'package:oshinstar/modules/finance/finance.dart';
import 'package:oshinstar/modules/profile/widgets/user_avatar.dart';
import 'package:oshinstar/modules/settings/settings.dart';
import 'package:oshinstar/utils/themes/palette.dart';

class CustomDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String userAvatarUrl;
  final String accountType;
  final bool isVerified; // Is email verified?
  

  const CustomDrawer({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userAvatarUrl,
    required this.accountType,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: const Color(0xFFEBEBEB),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const UserAvatarWidget(
                  src: "",
                  size: 75,
                  showBorder: true,
                  borderColor: Colors.white,
                  elevation: 10,
                  sizeIconPlaceHolder: 45,
                  hasAvatar: false,
                ),
                const SizedBox(height: 16),
                Text(
                  userName,
                  style: const TextStyle(color: OshinPalette.blue, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      userEmail,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    if (!isVerified)
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "(Verify now)",
                          style: TextStyle(color: OshinPalette.blue),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "Account type: $accountType",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Text(
                      "Switch to Star Pro I Account",
                      style: TextStyle(color: OshinPalette.blue),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.info_outline,
                        color: OshinPalette.blue, size: 16),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const Divider(),
          _buildDrawerItem(Icons.money, 'Finance & Credit', context),
          _buildDrawerItem(Icons.work_outline_rounded, 'Jobs', context),
          _buildDrawerItem(Icons.card_giftcard, 'Invite & win', context),
          _buildDrawerItem(Icons.visibility, 'Visibility & Privacy', context),
          _buildDrawerItem(Icons.settings, 'Settings', context),
          _buildDrawerItem(Icons.language, 'App Language', context),
          _buildDrawerItem(Icons.logout, 'Log Out', context),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        switch(title) {
          case 'Log Out':
          context.read<UserCubit>().logout(context);
          break;
          case 'Finance & Credit':
          Navigator.push(context, MaterialPageRoute(builder: (_) => const FinanceAuthenticateScreen()));
          case 'Settings':
          Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));

        }
      },
    );
  }
}
