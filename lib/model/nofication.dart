class NoficationModel {
  late int? id;
  late String? time;
  late String? date;
  late String? sessionId;
  late String? title;
  late String? content;
  late String? person;
  late String? userId;
  late String? image;

  NoficationModel(
      {this.id,
      this.image,
      this.content,
      this.date,
      this.time,
      this.title,
      this.sessionId,
      this.userId,
      this.person});

  factory NoficationModel.fromJson(Map<String, dynamic> json) {
    return NoficationModel(
      title: json['title'],
      time: json['time'],
      date: json['date'],
      sessionId: json['sessionId'],
      content: json['contentNoti'],
      image: json['image'],
    );
  }
}