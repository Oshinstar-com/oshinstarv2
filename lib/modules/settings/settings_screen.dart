part of 'settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool twoFactorSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            color: Colors.grey[300],
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Row(
              children: [Text("Account")],
            ),
          ),
          ListTile(
            title: const Text("Manage Account"),
            leading: const Icon(Icons.account_circle),
            onTap: () => AppRouter.route(context, const ManageAccountScreen()),
          ),
          ListTile(
            title: const Text("Limits & Features"),
            leading: const Icon(Icons.warning_amber_outlined),
            onTap: () => AppRouter.route(context, LimitsFeaturesScreen()),
          ),
          Container(
            height: 50,
            color: Colors.grey[300],
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Row(
              children: [Text("General")],
            ),
          ),
          const ListTile(
            title: Text("Notifications"),
            leading: Icon(Icons.notifications),
          ),
          ListTile(
            title: const Text("Preferred Measurement System"),
            subtitle: const Text(
              "Metric",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: const Icon(Icons.straighten),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext modalContext) {
                    return const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text("Metric System"),
                          trailing: Icon(Icons.check),
                        ),
                        ListTile(
                          title: Text("Imperial System"),
                          trailing: null,
                        )
                      ],
                    );
                  });
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text("Two-Factor Authentication"),
            subtitle: const Text(
                "Enabling two factor authentication makes it extra difficult for anyone other than you to access your account"),
            trailing: Switch(
                value: twoFactorSwitch,
                onChanged: (bool value) {
                  AppRouter.route(context, TwoFactorSetupScreen(clientId: 66));
                  setState(() {
                    twoFactorSwitch = value;
                  });
                }),
          )
        ],
      ),
    );
  }
}
