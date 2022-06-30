import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Client {
  Client({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.address,
    required this.photo,
    required this.caption,
    this.createdAt,
    this.updatedAt,
    this.deleted,
  });

  int? id;
  String firstname;
  String lastname;
  String email;
  final String? address;
  final String photo;
  final String? caption;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? deleted;

  get photoImage {
    if (photo != '') return NetworkImage(photo);
    return const AssetImage('assets/no-user-image.jpg');
  }

  factory Client.fromJson(String str) => Client.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Client.fromMap(Map<String, dynamic> json) => Client(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        address: json["address"],
        photo: json["photo"],
        caption: json["caption"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deleted: json["deleted"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "address": address,
        "photo": photo,
        "caption": caption,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted": deleted,
      };

  Client copy() => Client(
        id: id,
        firstname: firstname,
        lastname: lastname,
        email: email,
        address: address,
        photo: photo,
        caption: caption,
        createdAt: createdAt,
        updatedAt: updatedAt,
        deleted: deleted,
      );
}
