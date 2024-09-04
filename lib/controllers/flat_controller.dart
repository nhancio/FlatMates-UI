import 'package:flatmates/models/flatmate_model.dart';
import 'package:flatmates/repo/flat_repo.dart';
import 'package:get/get.dart';


class FlatController extends GetxController {


  var isLoading = true.obs;
  var flatmatesList = <FlatmateModel>[].obs;

  @override
  void onInit() {
    fetchFlatmates();
    super.onInit();
  }

  void fetchFlatmates() async {
    try {
      isLoading(true);
      var users = await FlatRepo().fetchUsers();
      flatmatesList.value = users;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load users');
    } finally {
      isLoading(false);
    }
  }
}
