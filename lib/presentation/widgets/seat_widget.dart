import 'package:flutter/material.dart';

class SeatWidget extends StatelessWidget {
  const SeatWidget({
    super.key,
    this.index,
    this.color,
    this.height = 50,
    this.width = 50,
    this.radius = 10,
  });

  final int? index;
  final Color? color;
  final double height, width, radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(radius),
      ),
      child:
          index == null ? null : Center(child: Text((index! + 1).toString())),
    );
  }
}
