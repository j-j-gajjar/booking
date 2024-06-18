import 'package:booking/navigation/app_routes.dart';
import 'package:booking/presentation/grid/grid_controller.dart';
import 'package:booking/presentation/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueScreen extends StatelessWidget {
  VenueScreen({super.key});

  final GridController gridController = Get.put(GridController());
  final Rx<TextEditingController> rowsController = TextEditingController().obs;
  final Rx<TextEditingController> columnsController = TextEditingController().obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Venue'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              controller: rowsController.value,
              labelText: 'Enter rows',
            ),
            CustomTextField(
              controller: columnsController.value,
              labelText: 'Enter columns',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int rows = int.parse(rowsController.value.text);
                int columns = int.parse(columnsController.value.text);
                bool check = gridController.setGrid(rows, columns);
                if (check) Get.toNamed(RoutesConstants.gridScreen);
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
