import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/controller/obscure.dart';
import 'package:halowarga/views/pengurus/navbar_pengurus.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  final _key = GlobalKey<FormState>();
  final _obscureController = Get.find<ObscureController>();

  final _roleItems = ['Warga', 'Pengurus'];

  String _selectedRole = '';

  Widget _formField(TextEditingController controller, String hint, bool obscure,
      {Widget? suffix}) {
    return Container(
      height: 56,
      // padding: EdgeInsets.symmetric(horizontal: 20),
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
        padding: EdgeInsets.symmetric(horizontal: 20),
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
                  Container(
                    height: 56,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.placeholder,
                    ),
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      decoration: InputDecoration(border: InputBorder.none),
                      dropdownColor: AppColor.white,
                      style: TextStyle(
                          color: AppColor.secondaryText, fontSize: 13),
                      hint: Text(
                        'PIlih Status Anda',
                        style: TextStyle(fontSize: 13),
                      ),
                      items: _roleItems.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                            child: Text(value), value: value);
                      }).toList(),
                      onChanged: (value) => _selectedRole = value.toString(),
                      onSaved: (value) => _selectedRole = value.toString(),
                      validator: (value) {
                        if (value == null) {
                          return "Role boleh kosong";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              )),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => Get.to(() => NavBarPengurus()),
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
