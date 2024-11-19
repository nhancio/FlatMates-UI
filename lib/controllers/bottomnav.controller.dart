import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs; // Reactive variable to hold the current index

  void setIndex(int index) {
    currentIndex.value = index; // Update the index
  }
}
