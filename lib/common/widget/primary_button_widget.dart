import 'package:flutter/material.dart';

class PrimaryElevatedButton extends StatelessWidget {
  const PrimaryElevatedButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.color = Colors.amber,
  }) : super(key: key);
  final String title;
  final Color? color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all(const StadiumBorder())),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(title),
          ),
        ),
      ),
    );
  }
}
