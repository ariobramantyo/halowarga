import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:halowarga/controller/user_controller.dart';
import 'package:halowarga/model/user.dart';

final userController = Get.find<UserController>();

class FirestoreService {
  static Future<void> addUserDataToFirestore(
      User? user, UserData userData) async {
    final checkUser = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get();

    if (checkUser.data() == null) {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .set(userData.toMap());
    }

    await getUserDataFromFirebase(user);

    // final currentUser =
    //     await FirebaseFirestore.instance.collection('user').doc(user.uid).get();

    // final currentUserData = currentUser.data() as Map<String, dynamic>;

    // userController.loggedUser.value = UserData(
    //     name: currentUserData['name'],
    //     email: currentUserData['email'],
    //     no: currentUserData['no'],
    //     imageUrl: currentUserData['imageUrl']);
  }

  static Future<void> getUserDataFromFirebase(User? user) async {
    if (user != null) {
      final currentUser = await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .get();

      final currentUserData = currentUser.data() as Map<String, dynamic>;

      userController.loggedUser.value = UserData(
        uid: currentUserData['uid'],
        name: currentUserData['name'],
        email: currentUserData['email'],
        password: currentUserData['password'],
        address: currentUserData['address'],
        status: currentUserData['status'],
        role: currentUserData['role'],
        no: currentUserData['no'],
        imageUrl: currentUserData['imageUrl'],
      );
      userController.loggedUser.refresh();

      print(
          'ambil data user dari firestore ===============================================');
      print(userController.loggedUser.value);
    }
  }

  static Future<List<dynamic>?> isUserCitizen(User? user) async {
    final currentUser = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get();
    if (currentUser.data() != null) {
      return [
        currentUser['role'] == 'Warga',
        currentUser['status'] == 'accepted'
      ];
    } else {
      return [null, null];
    }
  }
}
