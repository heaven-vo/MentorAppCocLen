class MeetupModel {
  final String? sessionId;
  final String? subject;
  final String? mentorName;
  final String? date;
  final int? slot;
  final double? price;
  final String? description;
  final String? majorId;
  final String? majorName;
  final String? image;
  final List? member;
  final List? listMentorInvite;
  final String? cafeName;
  final String? cafeStreet;
  final String? cafeDistric;
  final Map<String, dynamic>? cafe;
  final int? isJoin;
  final bool? isLead;
  final List? listMemberImage;
  final List? listMember;
  final int? status;

  MeetupModel(
      {this.description,
      this.mentorName,
      this.majorId,
      this.majorName,
      this.listMentorInvite,
      this.subject,
      this.cafeDistric,
      this.cafeStreet,
      this.cafe,
      this.date,
      this.cafeName,
      this.slot,
      this.price,
      this.image,
      this.isJoin,
      this.listMemberImage,
      this.member,
      this.status,
      this.isLead,
      this.listMember,
      this.sessionId});

  factory MeetupModel.fromJson(Map<String, dynamic> json) {
    return MeetupModel(
      sessionId: json['sessionId'] == null ? json['id'] :json['sessionId'],
      mentorName: json['mentorName'],
      description: json['description'],
      subject: json['subjectName'] == null ? json['sessionName'] : json['subjectName'],
      majorName: json['majorName'],
      majorId: json['majorId'],
      isJoin: json['isJoin'],
      listMemberImage: json['listMemberImage'],
      slot: json['slot'],
      date: json['date'],
      price: json['price'] == null ? 0.0 : json['price'].toDouble(),
      image: json['subjectImage'] == null ? json['sessionImage'] : json['subjectImage'],
      cafeName: json['cafeName'],
      cafeStreet: json['cafeStreet'],
      cafeDistric: json['cafeDistric'],
      listMentorInvite: json['listMentor'],
      listMember: json['listMember'],
      cafe: json['cafe'],
      status: json['status'],
      isLead: json['isLead'],
    );
  }
}
