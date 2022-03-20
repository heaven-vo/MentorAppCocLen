class MajorModel {
  String majorId;
  String majorName;
  bool? status;

  MajorModel({required this.majorId, required this.majorName, this.status});

  factory MajorModel.fromJson(Map<String, dynamic> json) {
    return MajorModel(
      majorId: json['id'],
      majorName: json['name'],
      status: json['status'],
    );
  }
}
