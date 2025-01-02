import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs; // Reactive variable to hold the current index
  var hoverIndex = Rxn<int>(); // Use Rxn to hold a nullable integer for hover state

  void setIndex(int index) {
    currentIndex.value = index; // Update the index
  }

  void setHoverIndex(int? index) {
    hoverIndex.value = index; // Update the hover state
  }
}
