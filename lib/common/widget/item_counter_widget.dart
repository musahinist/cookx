import 'package:flutter/material.dart';

class ItemCounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
              //padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(Icons.add)),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('1'),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            // padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Icon(Icons.remove),
          ),
        ),
      ],
    );
  }
}
