import 'dart:convert';

import 'package:minimal_app/models/models.dart';

class ClientsResponse {
  ClientsResponse({
    required this.success,
    required this.response,
  });

  final bool success;
  final Response response;

  factory ClientsResponse.fromJson(String str) => ClientsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClientsResponse.fromMap(Map<String, dynamic> json) => ClientsResponse(
        success: json["success"],
        response: Response.fromMap(json["response"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "response": response.toMap(),
      };
}

class Response {
  Response({
    required this.currentPage,
    required this.data,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    this.nextPageUrl,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  final int currentPage;
  final List<Client> data;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final String? nextPageUrl;
  final String perPage;
  final dynamic prevPageUrl;
  final int to;
  final int total;

  factory Response.fromJson(String str) => Response.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Response.fromMap(Map<String, dynamic> json) => Response(
        currentPage: json["current_page"],
        data: List<Client>.from(json["data"].map((x) => Client.fromMap(x))),
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data": List<Client>.from(data.map((x) => x.toMap())),
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}
