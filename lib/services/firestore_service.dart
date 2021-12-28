import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halowarga/controller/user_controller.dart';
import 'package:halowarga/model/announce.dart';
import 'package:halowarga/model/document.dart';
import 'package:halowarga/model/financeReport.dart';
import 'package:halowarga/model/report.dart';
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

  static void acceptCitizen(String uid, String status, String nama) {
    print(uid);
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .update({'status': status});

    if (status == 'accepted') {
      Get.snackbar('Perubahan berhasil disimpan',
          '$nama telah diterima menjadi anggota RT 03 Kelurahan Pesalakan',
          colorText: Colors.black);
    } else {
      Get.snackbar('Perubahan berhasil disimpan',
          '$nama telah ditolak menjadi anggota RT 03 Kelurahan Pesalakan',
          colorText: Colors.black);
    }
  }

  static void addAnnounce(Announcement announcement) {
    FirebaseFirestore.instance
        .collection('announcement')
        .add(announcement.toMap());

    Get.snackbar('Pengumuman berhasil dikirim',
        'pengumuman akan dilihat oleh warga RT 03 Kelurahan Pesalakan',
        colorText: Colors.black);
  }

  static void addReport(Report report) {
    FirebaseFirestore.instance.collection('report').add(report.toMap());

    Get.snackbar('Laporan berhasil dikirim',
        'Harap tunggu informasi selanjutnya dari pengurus RT',
        colorText: Colors.black);
  }

  static void sendReport(Document document) {
    FirebaseFirestore.instance.collection('document').add(document.toMap());

    Get.snackbar('Surat berhasil dikirim',
        'Harap tunggu informasi selanjutnya dari pengurus RT',
        colorText: Colors.black);
  }

  static void addIncome(FinanceReport financeReport, String type) {
    FirebaseFirestore.instance
        .collection('financeReport')
        .add(financeReport.toMap());

    Get.snackbar(
        type == 'income'
            ? 'Pemasukan berhasil ditambahkan'
            : 'Pengeluaran berhasil ditambah',
        '',
        colorText: Colors.black);
  }

  static Future<int> getTotalBalance() async {
    final totalBalance = await FirebaseFirestore.instance
        .collection('financeReport')
        .doc('totalBalance')
        .get();

    if (totalBalance.exists) {
      return totalBalance['totalBalance'];
    } else {
      await FirebaseFirestore.instance
          .collection('user')
          .doc('totalBalance')
          .set({'totalBalance': 0});
      print('set total balance');
      return 0;
    }
  }

  static Future updateTotalBalance(int value) async {
    print('ambil total balance function');
    final totalBalance = await FirebaseFirestore.instance
        .collection('financeReport')
        .doc('totalBalance')
        .get();
    print('selesai ambil total balance');
    if (totalBalance.exists) {
      print('exist');
      await FirebaseFirestore.instance
          .collection('financeReport')
          .doc('totalBalance')
          .update(
              {'totalBalance': (totalBalance['totalBalance'] as int) + value});
      print('update total balance');
      print('ini total balance ${totalBalance['totalBalance']}');
      print((totalBalance['totalBalance'] as int) + value);
      print(value);
    } else {
      print('doesnt exist');
      await FirebaseFirestore.instance
          .collection('financeReport')
          .doc('totalBalance')
          .set({'totalBalance': value});

      print('set total balance');
    }
  }

  static Future<List<UserData>> getListWarga() async {
    var listWargaSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('status', isEqualTo: 'accepted')
        .where('role', isEqualTo: 'Warga')
        .get();

    var listWarga = listWargaSnapshot.docs
        .map((value) => UserData.fromSnapshot(value))
        .toList();

    // print(listWarga.length);

    // List<String> listNamaWarga = [];

    // listWarga.forEach((element) {
    //   listNamaWarga.add(element.name!);
    // });

    return listWarga;
  }

  static void addUserMonthlyPayment(FinanceReport financeReport, String uid) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('monthlyPayment')
        .add(financeReport.toMap());
  }

  // static Future<List<String>> getListNamaWarga() async {
  //   var listWargaSnapshot = await FirebaseFirestore.instance
  //       .collection('user')
  //       .where('status', isEqualTo: 'accepted')
  //       .where('role', isEqualTo: 'warga')
  //       .get();

  //   var listWarga = listWargaSnapshot
  //       .map((value) => UserData.fromSnapshot(
  //           value as QueryDocumentSnapshot<Map<String, dynamic>>))
  //       .toList();

  //   List<String> listNamaWarga = [];

  //   listWarga.forEach((element) {
  //     listNamaWarga.add(element.name!);
  //   });

  //   return listNamaWarga;
  // }
}
