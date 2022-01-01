import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:halowarga/const/colors.dart';
import 'package:halowarga/controller/user_controller.dart';
import 'package:halowarga/model/user.dart';
import 'package:halowarga/services/auth_service.dart';
import 'package:halowarga/services/firestore_service.dart';
import 'package:halowarga/views/login_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationPage extends StatefulWidget {
  VerificationPage();

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  final _userController = Get.find<UserController>();

  void _errorDialog(String title, String message) => Get.defaultDialog(
        title: title,
        middleText: message,
        barrierDismissible: false,
        onConfirm: () async {
          Get.back();
        },
      );

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Halaman Verifikasi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
              child: Text(
                'Masukkan kode verifikasi untuk menjadi pengurus dari RT 03 Kelurahan Pesalakan',
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 20,
          ),
          Form(
            key: formKey,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: AppColor.mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 6,
                  obscureText: true,
                  obscuringCharacter: '*',
                  obscuringWidget: Icon(
                    Icons.circle,
                    size: 20,
                    color: AppColor.mainColor,
                  ),
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 6) {
                      return "Harap isi semua kotak";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    selectedColor: AppColor.white,
                    activeColor: AppColor.white,
                    selectedFillColor: AppColor.placeholder,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  boxShadows: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) {
                    print("Completed");
                  },
                  // onTap: () {
                  //   print("Pressed");
                  // },
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              hasError ? "*Kode veridikasi salah" : "",
              style: TextStyle(
                  color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                formKey.currentState!.validate();
                // conditions for validating
                if (currentText != "517291") {
                  errorController!.add(ErrorAnimationType
                      .shake); // Triggering error shake animation
                  setState(() => hasError = true);
                } else {
                  setState(
                    () async {
                      hasError = false;
                      EasyLoading.show(status: 'loading...');
                      try {
                        print('sign up');
                        _userController.roleSignUp.value =
                            Get.arguments['role'];
                        _userController.statusSignUp.value =
                            Get.arguments['status'];

                        await AuthService.signUp(Get.arguments['email'],
                                Get.arguments['password'])
                            .then(
                          (value) => FirestoreService.addUserDataToFirestore(
                              value,
                              UserData(
                                uid: value!.uid,
                                name: Get.arguments['name'],
                                email: Get.arguments['email'],
                                password: Get.arguments['password'],
                                address: Get.arguments['address'],
                                role: Get.arguments['role'],
                                status: Get.arguments['status'],
                              )),
                        );
                        Navigator.popUntil(context,
                            (Route<dynamic> predicate) => predicate.isFirst);
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
                    },
                  );
                }
              },
              child: Text(
                'Login',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(353, 50),
                primary: AppColor.mainColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: TextButton(
                child: Text("Hapus"),
                onPressed: () {
                  textEditingController.clear();
                },
              )),
              Flexible(
                  child: TextButton(
                child: Text("Kembali"),
                onPressed: () {
                  Get.back();
                },
              )),
            ],
          )
        ],
      ),
    );
  }
}
