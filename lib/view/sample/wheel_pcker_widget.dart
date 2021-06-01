import 'package:flutter/material.dart';

class WheelPickerWidget extends StatelessWidget {
  WheelPickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5)),
            height: 40,
            child: RotatedBox(
              quarterTurns: -1,
              child: ListWheelScrollView(
                itemExtent: 16,
                // perspective: .01,
                useMagnifier: true,
                squeeze: 0.5,
                //  offAxisFraction: .3,
                physics: FixedExtentScrollPhysics(),
                overAndUnderCenterOpacity: .2,
                magnification: 1.5,
                children: List.generate(100, (_) {
                  return RotatedBox(
                      quarterTurns: 1,
                      child: Center(child: Text(_.toString())));
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
