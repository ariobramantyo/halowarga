import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController addressController;
  late TextEditingController nameController;
  var obscureSignUp = true.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    addressController = TextEditingController();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void toggleObscureSignUp() {
    obscureSignUp.value = !obscureSignUp.value;
  }
}
