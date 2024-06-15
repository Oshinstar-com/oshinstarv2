import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:oshinstar/cubits/cubits.dart';
import 'package:oshinstar/modules/home/screens/custom_drawer.dart';
import 'package:oshinstar/modules/profile/screens/profile.dart';
import 'package:oshinstar/modules/profile/widgets/user_avatar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const TrendingScreen(),
    const JobsScreen(),
    const DiscoverScreen(),
    const LibraryScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;

    return Scaffold(
      endDrawer:  CustomDrawer(
        userName: "${user['firstName']} ${user['lastName']}" ?? "",
        userEmail: user['email'] ?? "",
        userAvatarUrl: "https://cdn.discordapp.com/attachments/871539767332986880/1038048692004991036/image.png?ex=6668da6e&is=666788ee&hm=8bd39f1b06f564ecdc1b70a32ae9ebfabb54e05068d239213b8b1f3cbd336000&",
        accountType:  user['accountType'] ?? "",
        isVerified: user['isEmailVerified'] ?? false,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon:
              Image.asset("assets/oshinstar-logo.png", height: 100, width: 100),
          onPressed: () => null,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.search_outlined, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline_outlined, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.whatshot_outlined),
            label: 'Trending',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.work_outline_rounded),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.hubspot),
            label: 'Discover',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline_rounded),
            label: 'Library',
          ),
          const BottomNavigationBarItem(
            icon: UserAvatarWidget(
              size: 25,
              showBorder: true,
              borderColor: Colors.blue,
              widthBorder: 0.5,
              src: "https://cdn.discordapp.com/attachments/871539767332986880/1038048692004991036/image.png?ex=6668da6e&is=666788ee&hm=8bd39f1b06f564ecdc1b70a32ae9ebfabb54e05068d239213b8b1f3cbd336000&"
            ),
            label: "Profile"
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Trending Screen'));
  }
}

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Jobs Screen'));
  }
}

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Discover Screen'));
  }
}

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Library Screen'));
  }
}