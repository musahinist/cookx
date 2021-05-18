import 'package:flutter/material.dart';

class CircleIconButtonWidget extends StatelessWidget {
  const CircleIconButtonWidget({
    Key? key,
    required this.icon,
    this.radius = 24,
    required this.onPressed,
    required this.color,
  }) : super(key: key);
  final IconData icon;
  final double radius;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: color,
        child: IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
