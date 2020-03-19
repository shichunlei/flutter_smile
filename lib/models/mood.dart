import 'package:flutter/material.dart';

import 'mood_type.dart';

/// ID : 1
/// DiaryDate : "2020-03-10T00:00:00"
/// EmotionType : "Anxiety"
/// EmotionScore : 2
/// EmotionNotes : "test"
/// UserName : "info@yok.com.cn"
/// CreatedBy : "info@yok.com.cn"
/// CreatedDate : "2020-03-10 17:42:56"
/// ChangedBy : "info@yok.com.cn"
/// ChangedDate : "2020-03-10 17:42:56"

class Mood {
  int id;
  String diaryDate;
  String emotionType;
  num emotionScore;
  String emotionNotes;
  String userName;
  String createdBy;
  String createdDate;
  String changedBy;
  String changedDate;

  Color color;

  static Mood fromMap(BuildContext context, Map<String, dynamic> map) {
    if (map == null) return null;
    Mood moodBean = Mood();
    moodBean.id = map['ID'];
    moodBean.diaryDate = map['DiaryDate'];
    moodBean.emotionType = map['EmotionType'];
    moodBean.emotionScore = map['EmotionScore'];
    moodBean.emotionNotes = map['EmotionNotes'];
    moodBean.userName = map['UserName'];
    moodBean.createdBy = map['CreatedBy'];
    moodBean.createdDate = map['CreatedDate'];
    moodBean.changedBy = map['ChangedBy'];
    moodBean.changedDate = map['ChangedDate'];

    types(context).forEach((item) {
      if (map['EmotionType'] == item.name) {
        moodBean.color = item.color;
      }
    });

    return moodBean;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "diaryDate": diaryDate,
        "emotionType": emotionType,
        "emotionScore": emotionScore,
        "emotionNotes": emotionNotes,
        "userName": userName,
        "createdBy": createdBy,
        "createdDate": createdDate,
        "changedBy": changedBy,
        "changedDate": changedDate,
      };
}
