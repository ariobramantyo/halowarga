import 'package:get/get.dart';

class ObscureController extends GetxController {
  var obscureLogin = true.obs;
  var obscureSignUp = true.obs;

  void toggleObscureLogin() {
    obscureLogin.value = !obscureLogin.value;
  }

  void toggleObscureSignUp() {
    obscureSignUp.value = !obscureSignUp.value;
  }
}
