import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:minimal_app/providers/providers.dart';
import 'package:minimal_app/widgets/widgets.dart';

class ClientForm extends StatelessWidget {
  final String title;

  const ClientForm({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientsProvider>(context);
    final selectedClient = clientProvider.selectedClient;

    return SingleChildScrollView(
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        titlePadding: const EdgeInsets.symmetric(horizontal: 30.5, vertical: 27.0),
        title: Text(title),
        contentPadding: const EdgeInsets.symmetric(horizontal: 30.5),
        content: SizedBox(
          width: 301,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 19),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 69.5,
                backgroundImage: const AssetImage('assets/no-image.png'),
                child: CircleAvatar(
                  radius: 67.5,
                  backgroundImage: selectedClient.photoImage,
                ),
              ),
              const SizedBox(height: 19),
              TextFormField(
                initialValue: selectedClient.firstname,
                onChanged: (value) => selectedClient.firstname = value,
                decoration: const InputDecoration(hintText: 'First name*', hintStyle: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 13),
              TextFormField(
                initialValue: selectedClient.lastname,
                onChanged: (value) => selectedClient.lastname = value,
                decoration: const InputDecoration(hintText: 'Last name*', hintStyle: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 13),
              TextFormField(
                initialValue: selectedClient.email,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => selectedClient.email = value,
                decoration: const InputDecoration(hintText: 'Email address*', hintStyle: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 34),
            ],
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        actions: [
          MaterialButton(
            child: const Text('Cancel', style: TextStyle(fontSize: 14)),
            elevation: 5,
            textColor: Colors.grey,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 159,
            child: BlackButton(
              padding: const EdgeInsets.symmetric(vertical: 13),
              text: 'SAVE',
              onPressed: clientProvider.isSaving
                  ? null
                  : () async {
                      await clientProvider.saveOrCreateClient(selectedClient);
                      Navigator.pop(context);
                    },
            ),
          ),
        ],
      ),
    );
  }
}
