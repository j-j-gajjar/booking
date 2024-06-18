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

  void setGrid(int r, int c) {
    if (r < 1 || c < 1) {
      showSnack(message: 'Please enter valid rows and columns');
      return;
    }
    rows.value = r;
    columns.value = c;
    unAvailableSeats.clear();
  }

  String getUserSeats() {
    return (userSeats.value + bookSeats.length).toString();
  }

  int availableSeats() {
    return (rows.value * columns.value) - unAvailableSeats.length;
  }

  void toggleContainer(int index) {
    if (Get.previousRoute == '/userScreen') {
      // USER

      //check if seats == 0 and bookSeats != 0 then reset bookSeats
      if (userSeats.value == 0 && bookSeats.isNotEmpty) {
        userSeats.value = bookSeats.length;
        bookSeats.clear();
      }

      int nextSeats = columns.value - (index % columns.value + 1);

      if (bookSeats.contains(index)) {
        bookSeats.remove(index);
        userSeats++;
        return;
      } else {
        bookSeats.add(index);
        userSeats--;
      }
      for (int i = 1; i <= nextSeats && userSeats > 0; i++) {
        if (!unAvailableSeats.contains(index + i)) {
          bookSeats.add(index + i);
          userSeats--;
        } else {
          break;
        }
      }
    } else {
      //ADMIN
      if (selectedIndices.contains(index)) {
        selectedIndices.remove(index);
      } else {
        selectedIndices.add(index);
      }
    }
  }

  void submit() {
    if (Get.previousRoute == '/userScreen') {
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
    } else {
      unAvailableSeats.clear();
      unAvailableSeats.addAll(selectedIndices);
      selectedIndices.clear();
      Get.offNamed(RoutesConstants.userScreen);
      isAdmin.value = false;
    }
  }
}
