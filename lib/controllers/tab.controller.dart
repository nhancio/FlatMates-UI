import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabControllerState extends GetxController
    with SingleGetTickerProviderMixin {
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    // Initialize TabController with 2 tabs
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose(); // Dispose the TabController when not needed
    super.onClose();
  }

  // Method to programmatically switch tabs
  void switchTab(int index) {
    tabController.animateTo(index); // Switch to the specified tab
  }
}
