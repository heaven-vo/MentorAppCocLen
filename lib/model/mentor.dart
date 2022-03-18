import 'package:flutter/material.dart';

class MentorModel {
  String? id;
  String? fullname;
  String? address;
  String? description;
  String? phone;
  String? image;
  String? sex;
  int? price;
  String? birthday;
  String? slogan;
  bool? status;
  double? rate;
  List<dynamic>? listCertificate;
  List<dynamic>? listMajor;
  List<dynamic>? listSkill;

  MentorModel(
      {this.id,
      this.fullname,
      this.address,
      this.description,
      this.sex,
      this.phone,
      this.price,
      this.slogan,
      this.image,
      this.birthday,
      this.status,
      this.rate,
      this.listMajor,
      this.listSkill,
      this.listCertificate});

  factory MentorModel.fromJson(Map<String, dynamic> json) {
    return MentorModel(
      id: json['id'],
      fullname: json['fullname'] == null ? json['name'] : json['fullname'],
      address: json['address'],
      description: json['description'],
      sex: json['sex'],
      phone: json['phone'],
      price: json['price'],
      image: json['image'],
      slogan: json['slogan'],
      birthday: json['birthday'],
      rate: json['rate'] == null ? 0.0 : json['rate'].toDouble(),
      status: json['status'],
      listMajor: json['listMajor'],
      listSkill: json['listSkill'],
      listCertificate: json['listCertificate'],
    );
  }
}
