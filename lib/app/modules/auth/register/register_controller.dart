import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:questionnaire/app/data/models/user_model.dart';
import 'package:questionnaire/app/data/repositories/auth_repository.dart';

class RegisterController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<bool> register() async {
    if (!formKey.currentState!.validate()) return false;

    isLoading.value = true;
    try {
      final user = UserModel(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        password: passwordController.text.trim(),
        avatar: 'https://avatars.githubusercontent.com/u/0',
      );

      await _authRepository.register(user);
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
