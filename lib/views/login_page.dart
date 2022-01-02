import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/controller/login_controller.dart';
import 'package:halowarga/services/auth_service.dart';
import 'package:halowarga/services/firestore_service.dart';
import 'package:halowarga/views/signup_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _key = GlobalKey<FormState>();
  final _loginController = Get.put(LoginController());

  void _errorDialog(String title, String message) => Get.defaultDialog(
        title: title,
        middleText: message,
        barrierDismissible: false,
        onConfirm: () async {
          Get.back();
        },
      );

  void _login() async {
    if (_key.currentState!.validate()) {
      EasyLoading.show(status: 'loading...');
      try {
        await AuthService.signIn(_loginController.emailController.text,
                _loginController.passwordController.text)
            .then((value) => FirestoreService.getUserDataFromFirebase(value));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          _errorDialog('Invalid Password', 'Wrong password or email');
        } else if (e.code == 'invalid-email') {
          _errorDialog(
              'Invalid Email', 'Please try again with the correct email!');
        } else if (e.code == 'user-not-found') {
          _errorDialog('User Not found',
              'Email that you use not registered yet. Try to sign up first');
        }
        EasyLoading.dismiss();
      } catch (e) {
        print(e.toString());
        EasyLoading.dismiss();
      }
      EasyLoading.dismiss();
    }
  }

  Widget _formField(TextEditingController controller, String hint, bool obscure,
      {Widget? suffix}) {
    return Container(
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          fontSize: 13,
          color: AppColor.black,
        ),
        obscureText: obscure,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 13, color: AppColor.secondaryText),
            filled: true,
            fillColor: AppColor.placeholder,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            suffixIcon: suffix),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Form tidak boleh kosong';
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/image/logo_og.svg',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 5),
            SvgPicture.asset(
              'assets/image/logo_text.svg',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 58),
            Form(
                key: _key,
                child: Column(
                  children: [
                    _formField(
                        _loginController.emailController, 'Email', false),
                    SizedBox(height: 10),
                    Obx(() => _formField(
                          _loginController.passwordController,
                          'Password',
                          _loginController.obscureLogin.value,
                          suffix: GestureDetector(
                            onTap: () => _loginController.toggleObscureLogin(),
                            child: _loginController.obscureLogin.value
                                ? Icon(
                                    Icons.visibility_off_outlined,
                                    color: AppColor.mainColor,
                                    size: 18,
                                  )
                                : Icon(
                                    Icons.visibility_outlined,
                                    color: AppColor.mainColor,
                                    size: 18,
                                  ),
                          ),
                        )),
                  ],
                )),
            SizedBox(height: 94),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: _login,
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(353, 56),
                  primary: AppColor.mainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
              ),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tidak punya akun?'),
                TextButton(
                    onPressed: () => Get.to(() => SignUpPage()),
                    child: Text(
                      'Daftar',
                      style: TextStyle(color: AppColor.mainColor),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
