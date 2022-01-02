import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:halowarga/model/user.dart';
import 'package:halowarga/services/firestore_service.dart';

class UserController extends GetxController {
  var loggedUser = UserData().obs;
  var roleSignUp = ''.obs;
  var statusSignUp = ''.obs;

  @override
  void onInit() async {
    await FirestoreService.getUserDataFromFirebase(
        FirebaseAuth.instance.currentUser);

    super.onInit();
  }
}
