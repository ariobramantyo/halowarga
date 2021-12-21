import 'dart:convert';

import 'package:crypto/crypto.dart';

class UserData {
  String? uid;
  String? name;
  String? email;
  String? password;
  String? address;
  String? role;
  String? status;
  String? no;
  String? imageUrl;

  UserData(
      {this.uid,
      this.name,
      this.email,
      this.password,
      this.address,
      this.role,
      this.status = 'accepted',
      this.no = '',
      this.imageUrl = ''});

  String _hashPass(String pass) {
    var bytes = utf8.encode(pass);
    return md5.convert(bytes).toString();
  }

  Map<String, dynamic> toMap() => {
        'uid': this.uid,
        'name': this.name,
        'email': this.email,
        'password': _hashPass(this.password!),
        'address': this.address,
        'status': this.status,
        'role': this.role,
        'no': this.no,
        'imageUrl': this.imageUrl,
      };

  UserData fromMap(Map<String, dynamic> map) => UserData(
        uid: map['uid'],
        name: map['name'],
        email: map['email'],
        password: map['password'],
        address: map['address'],
        status: map['status'],
        role: map['role'],
        no: map['no'],
        imageUrl: map['imageUrl'],
      );
}
