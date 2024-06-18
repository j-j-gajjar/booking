import 'package:booking/navigation/app_routes.dart';
import 'package:booking/presentation/widgets/widget.dart';
import 'package:get/get.dart';

class GridController extends GetxController with CommonMethod {
  RxInt rows = 0.obs;
  RxInt columns = 0.obs;
  RxList<int> selectedIndices = <int>[].obs;
  RxList<int> unAvailableSeats = <int>[].obs;
  RxList<int> bookSeats = <int>[].obs;
  RxInt userSeats = 0.obs;
  RxBool isAdmin = true.obs;

  // Method to set grid dimensions and reset unavailable seats
  bool setGrid(int r, int c) {
    if (r < 1 || c < 1) {
      showSnack(message: 'Please enter valid rows and columns');
      return false;
    }
    cleatSeats();

    rows.value = r;
    columns.value = c;
    return true;
  }

  // Method to get the total number of user seats
  String getUserSeats() {
    return (userSeats.value + bookSeats.length).toString();
  }

  // Method to calculate available seats
  int availableSeats() {
    return (rows.value * columns.value) - unAvailableSeats.length;
  }

  // Method to toggle seat selection based on the user or admin role
  void toggleContainer(int index) {
    if (Get.previousRoute == '/userScreen') {
      _toggleUserContainer(index);
    } else {
      _toggleAdminContainer(index);
    }
  }

  // Private method to handle user seat selection
  void _toggleUserContainer(int index) {
    // If all user seats are selected and tap again, reset bookSeats
    if (userSeats.value == 0 && bookSeats.isNotEmpty) {
      userSeats.value = bookSeats.length;
      bookSeats.clear();
    }

    // Calculate the number of seats to the end of the row from the current index
    int nextSeats = columns.value - (index % columns.value + 1);

    // If the seat is already booked, unselect it and increase the available userSeats
    if (bookSeats.contains(index)) {
      bookSeats.remove(index);
      userSeats++;
      return;
    }

    // Book the selected seat and decrease the available userSeats
    bookSeats.add(index);
    userSeats--;

    // Select adjacent seats if available and userSeats are greater than 0
    for (int i = 1; i <= nextSeats && userSeats > 0; i++) {
      if (!unAvailableSeats.contains(index + i)) {
        bookSeats.add(index + i);
        userSeats--;
      } else {
        break; // Stop if the next seat is unavailable
      }
    }
  }

  // Private method to handle admin seat selection
  void _toggleAdminContainer(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
  }

  // Method to submit seat selection based on the user or admin role
  void submit() {
    if (Get.previousRoute == '/userScreen') {
      _submitUserSelection();
    } else {
      _submitAdminSelection();
    }
  }

  // Private method to handle user seat selection submission
  void _submitUserSelection() {
    if (userSeats.value == 0 && bookSeats.isNotEmpty) {
      unAvailableSeats.addAll(bookSeats);
      List<int> selected = List.from(bookSeats);
      bookSeats.clear();
      Get.offNamed(
        RoutesConstants.summaryScreen,
        arguments: selected,
      );
    } else {
      showSnack(message: 'Please select seats');
    }
  }

  // Private method to handle admin seat selection submission
  void _submitAdminSelection() {
    // check not select all seats
    if (rows.value * columns.value == selectedIndices.length) {
      showSnack(message: 'Please leave at least one seat');
      return;
    }

    unAvailableSeats.clear();
    unAvailableSeats.addAll(selectedIndices);
    selectedIndices.clear();
    Get.offNamed(RoutesConstants.userScreen);
    isAdmin.value = false;
  }

  void cleatSeats() {
    unAvailableSeats.clear();
    selectedIndices.clear();
  }

  setSeat(int seat) {
    userSeats.value = seat;
    bookSeats.clear();
  }
}
