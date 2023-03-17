import 'dart:convert';

LoginResponseModel loginResponseModelJson(String str) =>
    LoginResponseModel.fromJson(
      json.decode(str),
    );

class LoginResponseModel {
  late final String message;
  late final Data data;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    data = Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['message'] = message;
    _data['data'] = data.toJson();

    return _data;
  }
}

class Data {
  late final String fullName;
  late final String email;
  late final String address;
  late final String phone;
  late final String userId;
  late final String token;
  Data({
    required this.fullName,
    required this.email,
    required this.address,
    required this.phone,
    required this.userId,
    required this.token,
  });

  Data.fromJson(Map<String, dynamic> json) {
    fullName = json["fullName"];
    email = json["email"];
    address = json["address"];
    phone = json["phone"];
    userId = json["userId"];
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['fulName'] = fullName;
    _data['email'] = email;
    _data['address'] = address;
    _data['phone'] = phone;
    _data['userId'] = userId;
    _data['token'] = token;

    return _data;
  }
}
