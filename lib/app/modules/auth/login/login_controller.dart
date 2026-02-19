import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:questionnaire/app/data/models/user_model.dart';
import 'package:questionnaire/app/data/repositories/auth_repository.dart';
import 'package:questionnaire/app/data/services/local_storage_service.dart';
import 'package:questionnaire/app/routes/app_routes.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final isGoogleLoading = false.obs;
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final UserModel? user = await _authRepository.login(
        phoneController.text.trim(),
        passwordController.text.trim(),
      );

      if (user != null) {
        await LocalStorageService.saveUser({
          'id': user.id,
          'name': user.name,
          'phone': user.phone,
          'avatar': user.avatar,
        });

        Get.snackbar(
          'Success',
          'Welcome back, ${user.name}!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade400,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
        );
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.snackbar(
          'Error',
          'Invalid phone or password',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade400,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    isGoogleLoading.value = true;
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        isGoogleLoading.value = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final firebaseUser = userCredential.user;

      await LocalStorageService.saveUser({
        'id': firebaseUser?.uid ?? '',
        'name': firebaseUser?.displayName ?? '',
        'email': firebaseUser?.email ?? '',
        'avatar': firebaseUser?.photoURL ?? '',
        'phone': firebaseUser?.phoneNumber ?? '',
      });

      Get.snackbar(
        'Success',
        'Welcome, ${firebaseUser?.displayName ?? 'User'}!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Google sign-in failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    } finally {
      isGoogleLoading.value = false;
    }
  }

  void goToRegister() {
    Get.toNamed(AppRoutes.register);
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
