import 'dart:math';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:oshinstar/utils/themes/palette.dart';

class RandomColorGrid extends StatelessWidget {
  const RandomColorGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(), // Prevent independent scrolling
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Number of columns
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemCount: 8, // Number of squares
          itemBuilder: (context, index) {
            return Container(
              color: getRandomColor(),
              child: index == 7 // Check if this is the last item
                  ? const Center(
                      child: Text(
                        'Text in the middle',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : null,
            );
          },
        ),
      ),
    );
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}

class OshinTabBar extends StatelessWidget {
  final TabController? controller;
  final void Function(int index)? onTap;

  const OshinTabBar({
    super.key,
    required this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        tabBarTheme: const TabBarTheme(
          unselectedLabelColor: Color(0xffDAD9E2),
          labelColor: Colors.black,
        ),
      ),
      child: Container(
        color: Colors.grey[100],
        width: double.infinity,
        child: TabBar(
          padding: EdgeInsets.zero,
          onTap: onTap,
          controller: controller,
          isScrollable: true,
          indicatorColor: OshinPalette.grey,
          indicatorSize: TabBarIndicatorSize.tab,
          labelPadding: const EdgeInsets.symmetric(horizontal: 10), // Remove padding
          tabs: [
            const Tab(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.play_circle_filled),
                    SizedBox(width: 10),
                    Text("Videos"),
                  ],
                ),
              ),
            ),
            const Tab(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.photo),
                    SizedBox(width: 10),
                    Text("Photostream"),
                  ],
                ),
              ),
            ),
            const Tab(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.queue_music),
                    SizedBox(width: 10),
                    Text("Tracks"),
                  ],
                ),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(MdiIcons.collage),
                    const SizedBox(width: 10),
                    const Text("Collections"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}