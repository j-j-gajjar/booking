import 'package:booking/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key, required this.selectedSeats});
  final List<int> selectedSeats;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {},
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Summary'),
          leading: const SizedBox(),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Total Selected Seats: ${selectedSeats.length}"),
                const SizedBox(height: 10),
                const Text(
                  'Selected Seats No:',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  selectedSeats.map((e) => (e + 1)).toList().join(', '),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Get.offNamed(RoutesConstants.userScreen);
                  },
                  child: const Text('Book More'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(RoutesConstants.venueScreen);
                  },
                  child: const Text('Venue Screen'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
