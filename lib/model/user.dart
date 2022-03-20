class UserModel {
  String? id;
  String? fullname;
  String? image;
  String? birthday;
  String? address;
  String? phone;
  String? majorName;
  String? sex;

  UserModel({
    this.id,
    this.fullname,
    this.address,
    this.birthday,
    this.image,
    this.phone,
    this.majorName,
    this.sex,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullname: json['fullname'],
      image: json['image'],
      birthday: json['birthday'],
      address: json['address'],
      phone: json['phone'],
      majorName: json['majorName'],
      sex: json['sex'],
    );
  }
}
