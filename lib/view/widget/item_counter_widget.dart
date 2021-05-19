import 'package:flutter/material.dart';

class ItemCounterWidget extends StatelessWidget {
  const ItemCounterWidget({
    Key? key,
    required this.servings,
    required this.onPressedPlus,
    required this.onPressedMinus,
  }) : super(key: key);
  final int servings;
  final VoidCallback onPressedPlus;
  final VoidCallback onPressedMinus;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onPressedMinus,
          child: Container(
            // padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Icon(Icons.remove),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('$servings'),
        ),
        InkWell(
          onTap: onPressedPlus,
          child: Container(
              //padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(Icons.add)),
        ),
      ],
    );
  }
}
