import 'package:booking/navigation/app_routes.dart';
import 'package:booking/presentation/grid/grid_screen.dart';
import 'package:booking/presentation/summary/summary_screen.dart';
import 'package:booking/presentation/user/user_screen.dart';
import 'package:booking/presentation/venue/venue_screen.dart';
import 'package:get/get.dart';

// import '../presentation/grid/grid_binding.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: RoutesConstants.venueScreen,
      page: () => VenueScreen(),
    ),
    GetPage(
      name: RoutesConstants.gridScreen,
      page: () => const GridScreen(),
    ),
    GetPage(
      name: RoutesConstants.userScreen,
      page: () => UserScreen(),
    ),
    GetPage(
      name: RoutesConstants.summaryScreen,
      page: () => SummaryScreen(selectedSeats: Get.arguments as List<int>),
    ),
  ];
}
