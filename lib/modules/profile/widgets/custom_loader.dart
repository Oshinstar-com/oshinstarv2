import 'package:flutter/material.dart';

class CustomProgressLoader extends StatefulWidget {
  final double currentValue;
  final IconData icon;
  final String label;
  final Color color;
  final Duration duration;

  CustomProgressLoader({
    required this.currentValue,
    required this.icon,
    required this.label,
    required this.color,
    this.duration = const Duration(seconds: 2),
  });

  @override
  _CustomProgressLoaderState createState() => _CustomProgressLoaderState();
}

class _CustomProgressLoaderState extends State<CustomProgressLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation =
        Tween<double>(begin: 0, end: widget.currentValue).animate(_controller)
          ..addListener(() {
            setState(() {});
          });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                value: _animation.value,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(widget.color),
              ),
            ),
            Icon(widget.icon, size: 15),
          ],
        ),
        const SizedBox(height: 10),
        Text(widget.label,
            style: const TextStyle(
              color: Colors.black,
            )),
      ],
    );
  }
}
