/// UserName : "info@yok.com.cn"
/// Name : "王五"
/// Professional : null
/// PerformanceType : null
/// Specialize : null
/// Tel : null
/// Mobile : null
/// Department : null
/// Password : null
/// AppHomepage : "http://www.yoksoft.com/Apps/App?myweb=ccpm_Contract"
/// Status : null
/// ChangedBy : "info@yok.com.cn"
/// ChangedDate : "2019-08-27T09:24:20"
/// CreatedBy : "info@yok.com.cn"
/// CreatedDate : "2019-08-27T09:24:20"

class User {
  String id;
  String userName;
  String name;
  String mobile;
  String professional;
  String performanceType;
  String specialize;
  String tel;
  String department;
  String password;
  String appHomepage;
  String status;
  String changedBy;
  String changedDate;
  String createdBy;
  String createdDate;

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    User userBean = User();
    userBean.id = map['Id'];
    userBean.userName = map['UserName'];
    userBean.name = map['Name'];
    userBean.mobile = map['PhoneNumber'];
    userBean.professional = map['Professional'];
    userBean.performanceType = map['PerformanceType'];
    userBean.specialize = map['Specialize'];
    userBean.tel = map['Tel'];
    userBean.department = map['Department'];
    userBean.password = map['Password'];
    userBean.appHomepage = map['AppHomepage'];
    userBean.status = map['Status'];
    userBean.changedBy = map['ChangedBy'];
    userBean.changedDate = map['ChangedDate'];
    userBean.createdBy = map['CreatedBy'];
    userBean.createdDate = map['CreatedDate'];
    return userBean;
  }

  Map toJson() => {
        "id": id,
        "userName": userName,
        "name": name,
        "professional": professional,
        "performanceType": performanceType,
        "specialize": specialize,
        "tel": tel,
        "mobile": mobile,
        "department": department,
        "password": password,
        "appHomepage": appHomepage,
        "status": status,
        "changedBy": changedBy,
        "changedDate": changedDate,
        "createdBy": createdBy,
        "createdDate": createdDate,
      };
}
