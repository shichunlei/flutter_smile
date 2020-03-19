import 'package:smile/config/constant.dart';
import 'package:smile/utils/date_util.dart';
import 'package:smile/utils/utils.dart';

/// ID : 1
/// rownum : 1
/// GratitudeTime : "2020-03-11T00:00:00"
/// GratitudeNotes : "test"
/// UserName : "info@yok.com.cn"
/// CreatedBy : "info@yok.com.cn"
/// CreatedDate : "2020-03-11 10:11:56"
/// ChangedBy : "info@yok.com.cn"
/// ChangedDate : "2020-03-11 10:11:56"
/// Img : null

class Gratitude {
  int id;
  int rowNum;
  String gratitudeTime;
  String gratitudeNotes;
  String userName;
  String createdBy;
  String createdDate;
  String changedBy;
  String changedDate;
  String time;
  String image;
  List<String> images = [];

  static Gratitude fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Gratitude gratitude = Gratitude();
    gratitude.id = map['ID'];
    gratitude.gratitudeTime = DateUtils.formatDate(
        DateTime.parse(map['GratitudeTime'].replaceAll("T", " ")),
        formats: [yyyy, "-", mm, "-", dd, " ", HH, ":", nn]);
    gratitude.time = DateUtils.formatDate(
        DateTime.parse(map['GratitudeTime'].replaceAll("T", " ")),
        formats: [HH, ":", nn]);
    gratitude.gratitudeNotes = map['GratitudeNotes'];
    gratitude.userName = map['UserName'];
    gratitude.createdBy = map['CreatedBy'];
    gratitude.createdDate = map['CreatedDate'];
    gratitude.changedBy = map['ChangedBy'];
    gratitude.changedDate = map['ChangedDate'];
    gratitude.image = Utils.isEmptyString(map['Img']) ? "" : map['Img'];
    gratitude.rowNum = map['rownum'];

    if (Utils.isNotEmptyString(map['Img'])) {
      List<String> _images = map['Img'].toString().split(',');

      _images.forEach((item) {
        gratitude.images.add("${Constant.IMAGE_BASE_URL}$item");
      });
    }
    return gratitude;
  }

  Map toJson() => {
        "id": id,
        "gratitudeTime": gratitudeTime,
        "gratitudeNotes": gratitudeNotes,
        "userName": userName,
        "createdBy": createdBy,
        "createdDate": createdDate,
        "changedBy": changedBy,
        "changedDate": changedDate,
        "image": image,
        "rowNum": rowNum,
      };
}
