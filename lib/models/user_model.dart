import 'dart:convert';

class UserModel {
  int id;
  String name;
  String phone;
  bool isActive;
  bool isVerified;
  bool isActivated;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.isActive,
    required this.isVerified,
    required this.isActivated,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        isActive: json["is_active"],
        isVerified: json["is_verified"],
        isActivated: json["is_activated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "is_active": isActive,
        "is_verified": isVerified,
        "is_activated": isActivated,
      };
}
