import 'package:booking/presentation/grid/grid_controller.dart';
import 'package:booking/presentation/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Seats'),
      ),
      body: GetBuilder<GridController>(
        init: Get.find<GridController>(),
        builder: (gridController) {
          return Obx(() {
            return Center(
              child: Column(
                children: [
                  _buildHeaderText(gridController),
                  if (!gridController.isAdmin.value) _buildSeatStatusRow(),
                  _buildSeatsGrid(gridController),
                  _buildSubmitButton(gridController),
                ],
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildHeaderText(GridController gridController) {
    return Text(
      gridController.isAdmin.value ? "Select Unavailable Seats" : "Select Seats: ${gridController.getUserSeats()}",
    );
  }

  Widget _buildSeatStatusRow() {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SeatStatusWidget(
            text: 'Sold',
            color: Colors.grey.withOpacity(.4),
          ),
          const SeatStatusWidget(
            text: 'Selected',
            color: Colors.yellow,
          ),
          const SeatStatusWidget(
            text: 'Available',
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildSeatsGrid(GridController gridController) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(12),
        shrinkWrap: true,
        children: [
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: _buildSeatRows(gridController),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeatRows(GridController gridController) {
    return Column(
      children: List.generate(gridController.rows.value, (rowIndex) {
        return Row(
          children: List.generate(
            gridController.columns.value,
            (colIndex) {
              int index = rowIndex * gridController.columns.value + colIndex;
              return GestureDetector(
                onTap: gridController.unAvailableSeats.contains(index) ? null : () => gridController.toggleContainer(index),
                child: Obx(() {
                  return SeatWidget(
                    index: index,
                    color: _getSeatColor(gridController, index),
                  );
                }),
              );
            },
          ),
        );
      }),
    );
  }

  Color _getSeatColor(GridController gridController, int index) {
    if (gridController.bookSeats.contains(index)) {
      return Colors.yellow;
    } else if (gridController.unAvailableSeats.contains(index) || gridController.selectedIndices.contains(index)) {
      return Colors.grey.withOpacity(.4);
    } else {
      return Colors.white;
    }
  }

  Widget _buildSubmitButton(GridController gridController) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: ElevatedButton(
        onPressed: gridController.submit,
        child: Text(gridController.isAdmin.value ? 'Next' : 'Save'),
      ),
    );
  }
}
