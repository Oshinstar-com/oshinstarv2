
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:oshinstar/widgets/carousel_indicators.dart';
import 'package:websafe_svg/websafe_svg.dart' show WebsafeSvg;

class Carrousel extends StatefulWidget {
  final List<CarrouselItem> items;
  final bool autoPlay;
  final bool isSvg;

  Carrousel({
    required this.items,
    this.autoPlay = false,
    this.isSvg = false,
  });

  @override
  _CarrouselState createState() => _CarrouselState();
}

class _CarrouselState extends State<Carrousel> {
  int _activeIndex = 0;

  void _hadlePageChange(int index) {
    setState(() {
      _activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              autoPlayInterval: const Duration(seconds: 6),
              viewportFraction: 1.0,
              height: 330,
              autoPlay: widget.autoPlay,
              onPageChanged: (int index, _) => _hadlePageChange(index)),
          items: widget.items
              .map(
                (item) => Builder(builder: (BuildContext ctx) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 0, top: 20, left: 0, right: 0),
                          child: widget.isSvg
                              ? WebsafeSvg.asset(
                                  item.imgSrc,
                                  width: 160,
                                  height: 160,
                                )
                              : Image.asset(
                                  item.imgSrc,
                                  height: 160,
                                  width: 160,
                                ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          item.title,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          item.description,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        )
                      ],
                    ),
                  );
                }),
              )
              .toList(),
        ),
        CarrouselIndicators(
          activeIndex: _activeIndex,
          quantity: widget.items.length,
          style: IndicatorStyle.home,
        )
      ],
    );
  }
}

// carrrousel item definition
class CarrouselItem {
  String title;
  String description;
  String imgSrc;

  CarrouselItem(
      {required this.title,
      required this.description,
      required this.imgSrc});
}
