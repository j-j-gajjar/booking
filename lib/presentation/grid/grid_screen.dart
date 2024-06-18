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
      // Using GetBuilder to handle state management for GridController
      body: GetBuilder<GridController>(
        init: Get.find<GridController>(),
        builder: (gridController) {
          // Using Obx to update the UI when observable variables change
          return Obx(() {
            return Center(
              child: Column(
                children: [
                  // Header text indicating the mode (admin/user)
                  _buildHeaderText(gridController),
                  // Display seat status row only for non-admin users
                  if (!gridController.isAdmin.value) _buildSeatStatusRow(),
                  // Build the grid of seats
                  _buildSeatsGrid(gridController),
                  // Submit button to save or proceed
                  _buildSubmitButton(gridController),
                ],
              ),
            );
          });
        },
      ),
    );
  }

  // Method to build header text based on admin/user mode
  Widget _buildHeaderText(GridController gridController) {
    return Text(
      gridController.isAdmin.value ? "Select Unavailable Seats" : "Select Seats: ${gridController.getUserSeats()}",
    );
  }

  // Method to build the seat status row (Sold, Selected, Available)
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

  // Method to build the grid of seats
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

  // Method to build rows of seats
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

  // Method to get the color of a seat based on its status
  Color _getSeatColor(GridController gridController, int index) {
    if (gridController.bookSeats.contains(index)) {
      return Colors.yellow;
    } else if (gridController.unAvailableSeats.contains(index) || gridController.selectedIndices.contains(index)) {
      return Colors.grey.withOpacity(.4);
    } else {
      return Colors.white;
    }
  }

  // Method to build the submit button with appropriate label
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
