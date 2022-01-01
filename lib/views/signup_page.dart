import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/controller/signup_controller.dart';
import 'package:halowarga/controller/user_controller.dart';
import 'package:halowarga/model/user.dart';
import 'package:halowarga/services/auth_service.dart';
import 'package:halowarga/services/firestore_service.dart';
import 'package:halowarga/views/pengurus/varification_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final _key = GlobalKey<FormState>();
  final _signupController = Get.put(SignUpController());
  final _userController = Get.put(UserController());

  final _roleItems = ['Warga', 'Pengurus'];

  String _selectedRole = '';

  void _errorDialog(String title, String message) => Get.defaultDialog(
        title: title,
        middleText: message,
        barrierDismissible: false,
        onConfirm: () async {
          Get.back();
        },
      );

  void _signUp() async {
    if (_key.currentState!.validate()) {
      if (_selectedRole == 'Pengurus') {
        Get.to(() => VerificationPage(), arguments: {
          'name': _signupController.nameController.text,
          'email': _signupController.emailController.text,
          'password': _signupController.passwordController.text,
          'address': _signupController.addressController.text,
          'role': _selectedRole,
          'status': 'accepted',
        });
      } else {
        EasyLoading.show(status: 'loading...');
        try {
          print('sign up');
          _userController.roleSignUp.value = _selectedRole;
          _userController.statusSignUp.value =
              _selectedRole == 'Warga' ? 'waiting' : 'accepted';

          await AuthService.signUp(_signupController.emailController.text,
                  _signupController.passwordController.text)
              .then(
            (value) => FirestoreService.addUserDataToFirestore(
                value,
                UserData(
                  uid: value!.uid,
                  name: _signupController.nameController.text,
                  email: _signupController.emailController.text,
                  password: _signupController.passwordController.text,
                  address: _signupController.addressController.text,
                  role: _selectedRole,
                  status: _selectedRole == 'Pengurus' ? 'accepted' : 'waiting',
                )),
          );
          Get.back();
          print('sukses signup');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            _errorDialog('Invalid Password',
                'Password must contain atleast 6 character. Please try again with the correct password');
          } else if (e.code == 'invalid-email') {
            _errorDialog('Invalid Email',
                'Please try again with the correct email! format');
          } else if (e.code == 'email-already-in-use') {
            _errorDialog('Email Alredy Exists',
                'The email provided is already in use by an existing user. Please sign in with your registered email');
          }
          EasyLoading.dismiss();
        } catch (e) {
          print(e.toString());
          EasyLoading.dismiss();
        }
        EasyLoading.dismiss();
      }
    }
  }

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
                  _formField(_signupController.nameController, 'Nama', false),
                  SizedBox(height: 10),
                  _formField(
                      _signupController.addressController, 'Alamat', false),
                  SizedBox(height: 10),
                  _formField(_signupController.emailController, 'Email', false),
                  SizedBox(height: 10),
                  Obx(() => _formField(
                        _signupController.passwordController,
                        'Password',
                        _signupController.obscureSignUp.value,
                        suffix: GestureDetector(
                          onTap: () => _signupController.toggleObscureSignUp(),
                          child: _signupController.obscureSignUp.value
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
            onPressed: _signUp,
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
