import 'package:booking/navigation/app_routes.dart';
import 'package:booking/presentation/grid/grid_controller.dart';
import 'package:booking/presentation/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserScreen extends StatelessWidget with CommonMethod {
  UserScreen({super.key});
  final Rx<TextEditingController> seats = TextEditingController().obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Seats')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              "Available seats :  ${Get.find<GridController>().availableSeats().toString()}",
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: seats.value,
              labelText: 'How many seats do you want to book?',
              onChanged: (value) {
                if (int.parse(value) > Get.find<GridController>().availableSeats()) {
                  showSnack(message: 'Not enough available seats');
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (int.parse(seats.value.text) <= Get.find<GridController>().availableSeats()) {
                  Get.find<GridController>().setSeat(int.parse(seats.value.text));
                  seats.value.clear();
                  Get.toNamed(RoutesConstants.gridScreen);
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
