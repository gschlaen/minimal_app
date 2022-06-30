import 'dart:convert';

import 'package:minimal_app/models/models.dart';

class LoginResponse {
  LoginResponse({
    required this.success,
    this.user,
  });

  final bool success;
  final User? user;

  factory LoginResponse.fromJson(String str) => LoginResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        success: json["success"],
        user: json["success"] ? User.fromMap(json["response"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "response": user!.toMap(),
      };
}
