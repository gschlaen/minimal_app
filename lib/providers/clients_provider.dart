import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:minimal_app/global/environment.dart';
import 'package:minimal_app/models/models.dart';

class ClientsProvider extends ChangeNotifier {
  List<Client> clients = [];
  int limit = 5;
  int total = 0;
  late Client selectedClient;

  final storage = const FlutterSecureStorage();

  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

  ClientsProvider() {
    loadClients();
  }

  loadClients() async {
    isLoading = true;
    notifyListeners();

    final resp = await http.post(Uri.parse('${Environment.baseUrl}/client/list?limit=$limit'), body: jsonEncode({}), headers: {
      'Content-Type': 'application/json',
    });

    final clientsResponse = ClientsResponse.fromJson(resp.body);
    clients = clientsResponse.response.data;
    total = clientsResponse.response.total;
    isLoading = false;
    notifyListeners();
  }

  saveOrCreateClient(Client client) async {
    isSaving = true;
    notifyListeners();

    if (client.id == null) {
      // Create
      await createClient(client);
    } else {
      // Update
      await updateClient(client);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<int> updateClient(Client client) async {
    await http.post(Uri.parse('${Environment.baseUrl}/client/save'), body: client.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    final index = clients.indexWhere((element) => element.id == client.id);
    clients[index] = client;

    notifyListeners();
    return client.id!;
  }

  Future<int> createClient(Client client) async {
    final resp = await http.post(Uri.parse('${Environment.baseUrl}/client/save'), body: client.toJson(), headers: {
      'Content-Type': 'application/json',
    });
    final decodedData = jsonDecode(resp.body);
    client.id = decodedData['response']['id'];

    clients.insert(0, client);
    notifyListeners();

    return client.id!;
  }

  deleteClient(int id) async {
    await http.delete(Uri.parse('${Environment.baseUrl}/client/remove/$id'));
    clients.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  searchByQuery(String query) async {
    isLoading = true;
    notifyListeners();

    final resp = await http.post(Uri.parse('${Environment.baseUrl}/client/list?limit=$total'), body: jsonEncode({}), headers: {
      'Content-Type': 'application/json',
    });
    final clientsResponse = ClientsResponse.fromJson(resp.body);
    final totalClients = clientsResponse.response.data;

    query = query.toLowerCase();
    clients = totalClients
        .where((element) => element.firstname.toLowerCase().contains(query) || element.lastname.toLowerCase().contains(query))
        .toList();
    // isLoading = false;
    notifyListeners();
  }
}
