import 'package:flutter/material.dart';

class LocationModel {
  String? id;
  String? name;
  String? description;
  String? street;
  String? distric;
  String? image;
  String? openTime;
  String? closeTime;
  double? rate;

  LocationModel({
    this.id,
    this.name,
    this.street,
    this.closeTime,
    this.openTime,
    this.distric,
    this.description,
    this.image,
    this.rate,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      street: json['street'],
      distric: json['distric'],
      description: json['description'],
      image: json['image'],
      openTime: json['openTime'],
      closeTime: json['closeTime'],
      rate: json['rate'] == null ? 0.0 : json['rate'].toDouble(),
    );
  }
}
