import 'dart:convert';

import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../utils/date_util.dart';
import '../../utils/utils.dart';

import '../constant.dart';
import 'api.dart';

class ApiService {
  /// 登录
  ///
  /// [email] 邮箱
  /// [password] 密码
  ///
  Future<String> login(String email, String password) async {
    String result = '';

    var body = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <IsLogin xmlns="http://tempuri.org/">
        <username>$email</username>
        <pw>$password</pw>
    </IsLogin>
  </soap:Body>
</soap:Envelope>
''';

    var _response = await APIs.postData(
      "http://www.yoksoft.com/webapi/webservice1.asmx",
      body: body,
      headers: {
        "Content-Type": "text/xml; charset=utf-8",
        "SOAPAction": "http://tempuri.org/IsLogin",
        "Host": "www.yoksoft.com"
      },
    );

    if (_response != null) {
      debugPrint("===========> $_response");

      result =
          Utils.analysisResult(_response, "IsLoginResponse", "IsLoginResult");

      debugPrint("itemsList: $result");
    }
    return result;
  }

  /// 注册
  ///
  /// [email] 邮箱
  /// [password] 密码
  /// [name] 昵称
  ///
  Future signUp(String email, String name, String password) async {
    String result = '';

    var body = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <CreateUser xmlns="http://tempuri.org/">
        <username>$email</username>
        <name>$name</name>
        <pw>$password</pw>
    </CreateUser>
  </soap:Body>
</soap:Envelope>
''';

    var _response = await APIs.postData(
      "http://www.yoksoft.com/webapi/webservice1.asmx",
      body: body,
      headers: {
        "Content-Type": "text/xml; charset=utf-8",
        "SOAPAction": "http://tempuri.org/CreateUser",
        "Host": "www.yoksoft.com"
      },
    );

    if (_response != null) {
      debugPrint("===========> $_response");

      result = Utils.analysisResult(
          _response, "CreateUserResponse", "CreateUserResult");

      debugPrint("itemsList: $result");
    }

    return result;
  }

  /// 忘记密码
  ///
  /// [email] 邮箱
  ///
  Future<String> forgetPassword(String email) async {
    String result = '';

    var body = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <Forgot xmlns="http://tempuri.org/">
      <email>$email</email>
    </Forgot>
  </soap:Body>
</soap:Envelope>
''';

    var _response = await APIs.postData(
      "http://www.yoksoft.com/webapi/webservice1.asmx",
      body: body,
      headers: {
        "Content-Type": "text/xml; charset=utf-8",
        "SOAPAction": "http://tempuri.org/Forgot",
        "Host": "www.yoksoft.com"
      },
    );

    if (_response != null) {
      debugPrint("===========> $_response");

      String result =
          Utils.analysisResult(_response, "ForgotResponse", "ForgotResult");

      debugPrint("itemsList: $result");
    }
    return result;
  }

  /// 得到用户信息
  ///
  /// [email] 邮箱
  ///
  Future<User> getUserInfo(String email) async {
    User user;

    var body = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GetUerinfo xmlns="http://tempuri.org/">
      <username>$email</username>
    </GetUerinfo>
  </soap:Body>
</soap:Envelope>
''';

    var _response = await APIs.postData(
      "http://www.yoksoft.com/webapi/webservice1.asmx",
      body: body,
      headers: {
        "Content-Type": "text/xml; charset=utf-8",
        "SOAPAction": "http://tempuri.org/GetUerinfo",
        "Host": "www.yoksoft.com"
      },
    );

    if (_response != null) {
      debugPrint("===========> $_response");

      String _testValue = Utils.analysisResult(
          _response, "GetUerinfoResponse", "GetUerinfoResult");

      debugPrint("itemsList: $_testValue");

      List<User> _list = [];

      _list
        ..addAll((json.decode(_testValue) as List ?? [])
            .map((o) => User.fromMap(o)));

      user = _list.first;
    }
    return user;
  }

  /// 删除手机号码
  ///
  /// [email] 邮箱
  ///
  Future<String> removePhone(String email) async {
    String result = '';

    var body = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <RemovePhone xmlns="http://tempuri.org/">
      <username>$email</username>
    </RemovePhone>
  </soap:Body>
</soap:Envelope>
''';

    var _response = await APIs.postData(
      "http://www.yoksoft.com/webapi/webservice1.asmx",
      body: body,
      headers: {
        "Content-Type": "text/xml; charset=utf-8",
        "SOAPAction": "http://tempuri.org/RemovePhone",
        "Host": "www.yoksoft.com"
      },
    );

    if (_response != null) {
      debugPrint("===========> $_response");

      result = Utils.analysisResult(
          _response, "RemovePhoneResponse", "RemovePhoneResult");

      debugPrint("result: $result");
    }
    return result;
  }

  /// 获取验证码
  ///
  /// [email] 邮箱
  /// [mobile] 手机号码
  ///
  Future getVerifyCode(String email, String mobile) async {
    String result = '';

    var body = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <AddPhoneNumber xmlns="http://tempuri.org/">
      <username>$email</username>
      <number>$mobile</number>
    </AddPhoneNumber>
  </soap:Body>
</soap:Envelope>
''';

    var _response = await APIs.postData(
      "http://www.yoksoft.com/webapi/webservice1.asmx",
      body: body,
      headers: {
        "Content-Type": "text/xml; charset=utf-8",
        "SOAPAction": "http://tempuri.org/AddPhoneNumber",
        "Host": "www.yoksoft.com"
      },
    );

    if (_response != null) {
      debugPrint("===========> $_response");

      result = Utils.analysisResult(
          _response, "AddPhoneNumberResponse", "AddPhoneNumberResult");

      debugPrint("itemsList: $result");
    }
    return result;
  }

  /// 校验并添加手机号码
  ///
  /// [email] 邮箱
  /// [mobile] 手机号码
  /// [code] 验证码
  ///
  Future<String> verifyPhoneNumber(
      String email, String mobile, String code) async {
    String result = '';

    var body = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <VerifyPhoneNumber xmlns="http://tempuri.org/">
      <username>$email</username>
      <number>$mobile</number>
      <code>$code</code>
    </VerifyPhoneNumber>
  </soap:Body>
</soap:Envelope>
''';

    var _response = await APIs.postData(
      "http://www.yoksoft.com/webapi/webservice1.asmx",
      body: body,
      headers: {
        "Content-Type": "text/xml; charset=utf-8",
        "SOAPAction": "http://tempuri.org/VerifyPhoneNumber",
        "Host": "www.yoksoft.com"
      },
    );

    if (_response != null) {
      debugPrint("===========> $_response");

      result = Utils.analysisResult(
          _response, "VerifyPhoneNumberResponse", "VerifyPhoneNumberResult");

      debugPrint("itemsList: $result");
    }

    return result;
  }

  /// 上传图片
  ///
  /// [base64String] 图片Base64格式
  /// [fileName] 文件名
  ///
  Future<String> uploadFile(String base64String, String fileName) async {
    String result;

    var body = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <UploadFile xmlns="http://tempuri.org/">
      <fs>$base64String</fs>
      <path>${Constant.IMAGE_PATH}</path>
      <fileName>$fileName</fileName>
    </UploadFile>
  </soap:Body>
</soap:Envelope>
''';

    var _response = await APIs.postData(
      "http://www.yoksoft.com/webapi/webservice1.asmx",
      body: body,
      headers: {
        "Content-Type": "text/xml; charset=utf-8",
        "SOAPAction": "http://tempuri.org/UploadFile",
        "Host": "www.yoksoft.com"
      },
    );

    if (_response != null) {
      debugPrint("===========> $_response");

      result = Utils.analysisResult(
          _response, "UploadFileResponse", "UploadFileResult");

      debugPrint("itemsList: $result");
    }

    return result;
  }

  /// 发布Gratitude
  ///
  /// [email] 邮箱
  /// [imageUrl] 图片地址
  /// [notes] 内容
  ///
  Future<String> postGratitudeData(
      String email, String imageUrl, String notes) async {
    String result = '';

    var params = {
      "Type": "GratitudeSave",
      "gratitudeJsondata":
          '''{"GratitudeTime":"${DateUtils.formatDate(DateTime.now())}",
    "GratitudeNotes":"$notes",
    "Img":"$imageUrl",
    "UserName":"$email"}'''
    };

    var _response = await APIs.postData(
        "http://www.yoksoft.com/webapi/smile/SmileApi.ashx",
        body: params);

    if (_response != null) {
      Map<String, dynamic> _json = json.decode(_response);

      result = _json["success"];
    }

    return result;
  }

  /// 发布Mood
  ///
  /// [email] 邮箱
  /// [diaryDate] 日期
  /// [emotionType] 类型
  /// [emotionScore] 分数
  /// [notes] 故事
  ///
  Future<String> postMood(String email, String diaryDate, String emotionType,
      double emotionScore, String notes) async {
    String result = '';

    var params = {
      "Type": "MoodSave",
      "moodJsondata": '''{"DiaryDate":"$diaryDate",
    "EmotionType":"$emotionType",
    "EmotionScore":"${emotionScore.toInt()}",
    "EmotionNotes":"$notes",
    "UserName":"$email"}'''
    };

    var _response = await APIs.postData(
        "http://www.yoksoft.com/webapi/smile/SmileApi.ashx",
        body: params);

    if (_response != null) {
      debugPrint("===========> $_response");

      Map<String, dynamic> _json = json.decode(_response);

      result = _json["success"];
    }

    return result;
  }
}
