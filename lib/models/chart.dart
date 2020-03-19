/// TimeAxis : "2020-03-11"
/// EmotionScore : 2.5

class Chart {
  String diaryDate;
  double emotionScore;

  Chart({this.diaryDate, this.emotionScore});

  static Chart fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Chart chartBean = Chart();
    chartBean.diaryDate = map['DiaryDate'];
    chartBean.emotionScore = double.parse("${map['EmotionScore']}");
    return chartBean;
  }

  Map<String, dynamic> toJson() => {
        "diaryDate": diaryDate,
        "emotionScore": emotionScore,
      };
}
