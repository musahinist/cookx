import 'package:flutter/material.dart';

class ButtonOutlineStadiumWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color color;

  const ButtonOutlineStadiumWidget(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: OutlinedButton(
        style: ButtonStyle(
            //  backgroundColor: MaterialStateProperty.all(Colors.amber),
            shape: MaterialStateProperty.all(const StadiumBorder()),
            side: MaterialStateProperty.all(BorderSide(color: color))
            // foregroundColor: MaterialStateProperty.all(Colors.amber),
            ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}
