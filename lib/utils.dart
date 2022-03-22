import 'dart:collection';

//generate String major from list major
getMajorString(List majorList) {
  var majors = "";

  for (var element in majorList) {
    if (majors != "") {
      majors = "$majors, $element";
    } else {
      majors = element;
    }
  }
  return majors;
}

const SLOT = [
  "07:00 - 08:30",
  "08:45 - 10:15",
  "10:30 - 12:00",
  "12:30 - 14:00",
  "14:15 - 15:45",
  "16:00 - 17:30"
]; //
getSlot(int slot) {
  switch (slot) {
    case 1:
      return SLOT[0];
    case 2:
      return SLOT[1];
    case 3:
      return SLOT[2];
    case 4:
      return SLOT[3];
    case 5:
      return SLOT[4];
    case 6:
      return SLOT[5];

    default:
  }
}

getStatusString(int status) {
  switch (status) {
    case 0:
      return "Đang chờ Mentor xác nhận";
    case 1:
      return "Meeting đã được xác nhận";
    case 2:
      return "Meeting đã hoàn thành";
    case 3:
      return "Meeting đã hủy";
    default:
      return "Đang xử lý";
  }
}
