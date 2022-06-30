import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:minimal_app/models/models.dart';
import 'package:minimal_app/providers/providers.dart';
import 'package:minimal_app/widgets/widgets.dart';

class ClientCard extends StatelessWidget {
  final Client client;

  const ClientCard({
    Key? key,
    required this.client,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color.fromRGBO(26, 26, 26, 1)), borderRadius: BorderRadius.circular(20)),
      child: ListTile(
          contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
          leading: CircleAvatar(radius: 25, backgroundImage: client.photoImage),
          title:
              Text(client.firstname + ' ' + client.lastname, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          subtitle: Text(client.email, style: const TextStyle(fontSize: 12)),
          trailing: _SettingsPopupButton(client: client)),
    );
  }
}

class _SettingsPopupButton extends StatelessWidget {
  final Client client;

  const _SettingsPopupButton({
    Key? key,
    required this.client,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientsProvider>(context);

    return PopupMenuButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.black,
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: ListTile(
                    horizontalTitleGap: -10,
                    tileColor: Colors.black,
                    leading: const Icon(Icons.edit, color: Colors.white),
                    title: const Text('Edit', style: TextStyle(color: Colors.white, fontSize: 16)),
                    onTap: () {
                      clientProvider.selectedClient = client.copy();
                      Navigator.pop(context);
                      editClient(context);
                    }),
              ),
              PopupMenuItem(
                child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    horizontalTitleGap: -10,
                    tileColor: Colors.black,
                    leading: const Icon(Icons.delete, color: Colors.white),
                    title: const Text('Delete', style: TextStyle(color: Colors.white, fontSize: 16)),
                    onTap: () {
                      clientProvider.deleteClient(clientProvider.selectedClient.id!);
                      Navigator.pop(context);
                    }),
              ),
            ]);
  }

  editClient(context) {
    return showDialog(
        context: context,
        builder: (_) {
          return const ClientForm(title: 'Edit client');
        });
  }
}
