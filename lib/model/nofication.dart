class NoficationModel {
  late int id;
  late String time;
  late String title;
  late String content;
  late String person;
  late String userId;
  late String image;

  NoficationModel(
      {required this.id,
      required this.image,
      required this.content,
      required this.time,
      required this.title,
      required this.userId,
      required this.person});
}
