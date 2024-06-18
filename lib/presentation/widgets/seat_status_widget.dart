import 'package:booking/presentation/widgets/seat_widget.dart';
import 'package:flutter/material.dart';

class SeatStatusWidget extends StatelessWidget {
  const SeatStatusWidget({
    super.key,
    this.color,
    required this.text,
  });
  final Color? color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SeatWidget(
          color: color,
          width: 15,
          height: 15,
          radius: 3,
        ),
        Text(text),
      ],
    );
  }
}
