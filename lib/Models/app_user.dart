import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String? uid;
  String? email;
  String? name;
  String? image;
  String? role;
  Timestamp? createdAt;
  String? dateOfBirth;
  String? phone;
  String? address;
  String? cityProvince;

  AppUser({
    this.uid,
    this.email,
    this.name,
    this.createdAt,
    this.image,
    this.role,
    this.address,
    this.cityProvince,
    this.phone,
    this.dateOfBirth,
  });

  // receiving data from server
  static AppUser fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      createdAt: map['created_at'],
      image: map['image'],
      role: map['role'],
      dateOfBirth: map['dateOfBirth'],
      cityProvince: map['cityProvince'],
      phone: map['phone'],
      address: map['address'],
    );
  }

  // sending data to our server
  static Map<String, dynamic> toMap(AppUser userM) {
    return {
      'uid': userM.uid,
      'email': userM.email,
      'name': userM.name,
      'created_at': Timestamp.now(),
      'image': userM.image,
      'dateOfBirth': userM.dateOfBirth,
      'role': userM.role,
      'address': userM.address,
      'cityProvince': userM.cityProvince,
      'phone': userM.phone,
    };
  }
}
