import 'package:questionnaire/app/core/constants/api_constants.dart';
import 'package:questionnaire/app/data/models/user_model.dart';

import '../services/api_service.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  Future<List<UserModel>> getAllUsers() async {
    final response = await _apiService.get(ApiConstants.users);
    final List<dynamic> data = response.data;
    return data.map((json) => UserModel.fromJson(json)).toList();
  }

  Future<UserModel?> login(String phone, String password) async {
    final users = await getAllUsers();
    try {
      return users.firstWhere(
        (user) => user.phone == phone && user.password == password,
      );
    } catch (e) {
      return null;
    }
  }

  Future<UserModel> register(UserModel user) async {
    final response = await _apiService.post(
      ApiConstants.users,
      data: user.toJson(),
    );
    return UserModel.fromJson(response.data);
  }
}
