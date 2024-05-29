import 'package:flutter/material.dart';

class LogoContainer extends StatelessWidget {
  final double? marginTop;
  final double? height;

  LogoContainer({@required this.marginTop, @required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment(0.0, 0.0),
      // margin: EdgeInsets.only(top: marginTop ?? 0.0),
      child: Image.asset(
        "assets/oshinstar-text-logo.png",
        height: height,
      ),
    );
  }
}
