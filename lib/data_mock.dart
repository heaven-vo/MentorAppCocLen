import 'package:mentor_coclen/model/mentor.dart';
import 'package:mentor_coclen/model/nofication.dart';

var MENTOR_DATA = [
  MentorModel(
      id: "1",
      fullname: "Phạm Văn Dương",
      description:
          "Xin chào! Tôi có khoảng 5 năm kinh nghiệm dạy người lớn và trẻ em. Tôi kiên nhẫn, hiểu biết và thân thiện. Tôi thích giúp mọi người thực hành tiếng Anh của họ bằng cách trò chuyện thú vị về nhiều chủ đề. Tôi hy vọng sẽ nói chuyện với bạn sớm!!",
      image:
          "https://camblyavatars.s3.amazonaws.com/5e1652f28e140d1c194ba446s200?h=2905bf5571661770dcd05f9e812b1e50",
      rate: 5,
      address: "",
      birthday: "",
      phone: "",
      price: 100,
      sex: "male",
      listMajor: ['Kỹ Thuật Phần Mềm', 'Quản Trị Kinh Doanh'],
      status: true),
  MentorModel(
      id: "2",
      fullname: "Võ Chí Công",
      description:
          "Xin chào, tôi là Cônng. Tôi có hơn bốn mươi năm kinh nghiệm giảng dạy.",
      image:
          "https://camblyavatars.s3.amazonaws.com/5e5e806038ba58cd17b86d3es200",
      rate: 4,
      address: "",
      birthday: "",
      phone: "",
      price: 100,
      listMajor: ['Kỹ Thuật Phần Mềm'],
      sex: "male",
      status: true),
  MentorModel(
      id: "3",
      fullname: "Trấn Thành",
      description:
          "Xin chào, tôi là Thái. Tôi có hơn năm năm kinh nghiệm giảng dạy. Chuyên môn của tôi là lập trình",
      image:
          "https://camblyavatars.s3.amazonaws.com/5b1e3217aeaa4a00241c8f91s200?h=af8c3e4b50e327814ec80878a4641b56",
      rate: 4,
      address: "",
      birthday: "",
      listMajor: [
        'Kỹ Thuật Phần Mềm',
        'Tiếng Nhật',
        'Quản Trị Kinh Doanh'
      ],
      phone: "",
      price: 100,
      sex: "male",
      status: true),
  MentorModel(
      id: "4",
      fullname: "Hoàng Thái",
      description:
          "Xin chào, tôi là Thái. Tôi có hơn năm năm kinh nghiệm giảng dạy. Chuyên môn của tôi là lập trình",
      image:
          "https://camblyavatars.s3.amazonaws.com/5b1e3217aeaa4a00241c8f91s200?h=af8c3e4b50e327814ec80878a4641b56",
      rate: 4,
      address: "",
      birthday: "",
      listMajor: ['Tiếng Nhật'],
      phone: "",
      price: 100,
      sex: "male",
      status: true),
];

// var SUBJECT_DATA = [
//   SubjectModel(subjectId: "1", majorId: "1", subjectName: "Database"),
//   SubjectModel(subjectId: "2", majorId: "1", subjectName: "Programing"),
//   SubjectModel(subjectId: "3", majorId: "2", subjectName: "Nhật 1"),
//   SubjectModel(subjectId: "4", majorId: "2", subjectName: "Nhật 2"),
//   SubjectModel(subjectId: "5", majorId: "3", subjectName: "Anh 3"),
// ];
// var MAJOR_DATA = [
//   MajorModel(majorId: "1", majorName: "Kỹ thuật phầm mềm"),
//   MajorModel(majorId: "2", majorName: "Tiếng Nhật"),
//   MajorModel(majorId: "3", majorName: "Tiếng Anh"),
// ];

var NOFI_DATA = [
  NoficationModel(
      id: 1,
      image: MENTOR_DATA[0].image!,
      content: "Buổi học của bạn đã được giảng viên ",
      time: "19:03 PM, 22 thg 1, 2022",
      title: "Buổi học đã được xác nhận",
      userId: MENTOR_DATA[0].id!,
      person: MENTOR_DATA[0].fullname!),
  NoficationModel(
      id: 1,
      image: MENTOR_DATA[1].image!,
      content: "Buổi học của bạn đã được giảng viên ",
      time: "19:03 PM, 22 thg 1, 2022",
      title: "Buổi học đã được xác nhận",
      userId: MENTOR_DATA[0].id!,
      person: MENTOR_DATA[1].fullname!),
  NoficationModel(
      id: 1,
      image: MENTOR_DATA[2].image!,
      content: "Buổi học của bạn đã được giảng viên ",
      time: "19:03 PM, 22 thg 1, 2022",
      title: "Buổi học đã được xác nhận",
      userId: MENTOR_DATA[2].id!,
      person: MENTOR_DATA[2].fullname!),
  NoficationModel(
      id: 1,
      image: MENTOR_DATA[3].image!,
      content: "Buổi học của bạn đã được giảng viên ",
      time: "19:03 PM, 22 thg 1, 2022",
      title: "Buổi học đã được xác nhận",
      userId: MENTOR_DATA[0].id!,
      person: MENTOR_DATA[3].fullname!),
];
