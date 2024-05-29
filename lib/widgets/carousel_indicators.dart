import 'package:flutter/material.dart';

enum IndicatorStyle { home, profile }

class CarrouselIndicators extends StatelessWidget {
  final int? quantity;
  final int? activeIndex;
  final IndicatorStyle? style;

  CarrouselIndicators({
    @required this.quantity,
    @required this.activeIndex,
    @required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List.generate(
        quantity ?? 0,
        (index) => AnimatedContainer(
          duration: Duration(microseconds: 125),
          width:
              index == activeIndex && style == IndicatorStyle.profile ? 48 : 8,
          height: 8,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: index == activeIndex
                ? style == IndicatorStyle.home
                    ? Theme.of(context).primaryColor
                    : Colors.white
                : MaterialColor(0xffc8c8c8, {}),
          ),
        ),
      ),
    );
  }
}
