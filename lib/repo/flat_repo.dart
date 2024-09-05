import 'package:flatmates/models/flatmate_model.dart';
import 'package:flatmates/network/network_service.dart';

class FlatRepo {
  Future<List<FlatmateModel>> fetchUsers() async {
    try {
      final response = await NetworkService().getRequest(
        '/recommendations_flatmates/',
      ); // Replace with your actual API URL

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<FlatmateModel> users = (response.data as List)
            .map((userJson) => FlatmateModel.fromJson(userJson))
            .toList();
        return users;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }
}
