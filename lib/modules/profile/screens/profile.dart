import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:oshinstar/modules/profile/widgets/add_presentation.dart';
import 'package:oshinstar/modules/profile/widgets/profile_card.dart';
import 'package:oshinstar/modules/profile/widgets/profile_loaders.dart';
import 'package:oshinstar/modules/profile/widgets/profile_tabbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const ThemeMode themeMode = ThemeMode.dark;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final BoxController boxController = BoxController();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        debugPrint('FUXCK');
      }); // Rebuild when the tab changes
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    boxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    double bottomNavigationBarHeight =
        (MediaQuery.of(context).viewInsets.bottom > 0) ? 0 : 40;

    double appBarHeight = MediaQuery.of(context).size.height * 0.1;
    if (appBarHeight < 95) appBarHeight = 95;
    double minHeightBox =
        MediaQuery.of(context).size.height * 0.3 - bottomNavigationBarHeight;

    double maxHeightBox = MediaQuery.of(context).size.height -
        appBarHeight -
        bottomNavigationBarHeight;

    return Scaffold(
      body: SlidingBox(
        borderRadius: BorderRadius.zero,
        controller: boxController,
        minHeight: minHeightBox, //575
        maxHeight: maxHeightBox,
        draggableIconBackColor: Colors.white,
        style: BoxStyle.sheet,
        bodyBuilder: (sc, pos) => _body(sc, pos),
        collapsedBody: ProfileCard(),
        backdrop: Backdrop(
          body: _backdrop(true),
        ),
      ),
    );
  }

  _body(ScrollController sc, double pos) {
    return Column(
      children: [
        ProfileCard(),
        const SizedBox(
          height: 15,
        ),
        const Divider(thickness: 0.5, height: 0.5),
        AddPresentation(),
        const Divider(thickness: 0.5, height: 0.5),
        const SizedBox(
          height: 15,
        ),
        const ProfileLoaders(loaders: [
          {'value': 0.4},
          {'value': 0.4},
          {'value': 0.4},
        ]),
        const SizedBox(
          height: 15,
        ),
        OshinTabBar(controller: _tabController),
        // _buildTabContent(),
        if (_tabController.index == 0)
          const RandomColorGrid(
            path:
               [ 
                "https://steamuserimages-a.akamaihd.net/ugc/1031833986817717601/48F50D22DFEB74696B7BC0EB8DDF3B7277D33DB7/?imw=5000&imh=5000&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=false",
                "https://i.etsystatic.com/41114433/r/il/a4cbc6/4894655016/il_570xN.4894655016_or4m.jpg"
               ]

          ),
        if (_tabController.index == 1)
          const Center(child: Text('Content for Photostream')),
        if (_tabController.index == 2)
          const Center(child: Text('Content for Tracks')),
        if (_tabController.index == 3)
          const Center(child: Text('Content for Collections')),
        Container()
      ],
    );
  }

  _backdrop(bool hasAvatar) {
    return hasAvatar
        ? Container(
            color: Colors.white, // Set the background color to white
            padding: const EdgeInsets.only(top: 60, bottom: 40),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [Image.asset("assets/slide_5.png")],
            ),
          )
        : const ListTile(
            tileColor: Color.fromARGB(255, 233, 229, 229),
            title: Icon(Icons.camera_alt_outlined),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Add your cover as an Image, GIF or Collection."),
              ],
            ),
          );
  }
}
