import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/controller/obscure.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  final _key = GlobalKey<FormState>();
  final _obscureController = Get.find<ObscureController>();

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
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: 67,
            margin: EdgeInsets.only(top: 70, bottom: 70),
            child: Column(
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
              ],
            ),
          ),
          Form(
              key: _key,
              child: Column(
                children: [
                  _formField(_nameController, 'Nama', false),
                  SizedBox(height: 10),
                  _formField(_addressController, 'Alamat', false),
                  SizedBox(height: 10),
                  _formField(_emailController, 'Email', false),
                  SizedBox(height: 10),
                  Obx(() => _formField(
                        _passwordController,
                        'Password',
                        _obscureController.obscureSignUp.value,
                        suffix: GestureDetector(
                          onTap: () => _obscureController.toggleObscureSignUp(),
                          child: _obscureController.obscureLogin.value
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
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'Daftar',
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
              Text('Sudah punya akun?'),
              TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    'Login',
                    style: TextStyle(color: AppColor.mainColor),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
