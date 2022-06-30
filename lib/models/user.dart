import 'dart:convert';

class User {
  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.photo,
    required this.phone,
    this.facebookId,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.isNotification,
    this.caption,
    required this.tokenType,
    required this.accessToken,
  });

  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String photo;
  final String phone;
  final String? facebookId;
  final int role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int status;
  final int isNotification;
  final String? caption;
  final String tokenType;
  final String accessToken;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        photo: json["photo"],
        phone: json["phone"],
        facebookId: json["facebook_id"],
        role: json["role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        isNotification: json["is_notification"],
        caption: json["caption"],
        tokenType: json["token_type"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "photo": photo,
        "phone": phone,
        "facebook_id": facebookId,
        "role": role,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "is_notification": isNotification,
        "caption": caption,
        "token_type": tokenType,
        "access_token": accessToken,
      };
}
