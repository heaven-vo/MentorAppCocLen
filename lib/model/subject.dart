class SubjectModel {
  String subjectId;
  String subjectName;
  String majorId;
  SubjectModel({
    required this.subjectId,
    required this.majorId,
    required this.subjectName,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      subjectId: json['id'],
      subjectName: json['name'],
      majorId: json['majorId'],
    );
  }
}
