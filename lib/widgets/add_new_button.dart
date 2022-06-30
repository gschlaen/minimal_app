import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:minimal_app/models/models.dart';
import 'package:minimal_app/providers/providers.dart';
import 'package:minimal_app/themes/app_theme.dart';
import 'package:minimal_app/widgets/widgets.dart';

class AddNewButton extends StatelessWidget {
  const AddNewButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientsProvider>(context);

    return MaterialButton(
        height: 29,
        shape: const StadiumBorder(),
        disabledColor: Colors.grey,
        elevation: 5,
        color: AppTheme.primary,
        child: const SizedBox(
          child: Text('ADD NEW', style: TextStyle(fontSize: 13, color: Colors.white, letterSpacing: 0.5)),
        ),
        onPressed: () {
          clientProvider.selectedClient = Client(firstname: '', lastname: '', email: '', photo: '', address: '', caption: '');
          addNewClient(context);
        });
  }

  addNewClient(context) {
    return showDialog(
        context: context,
        builder: (_) {
          return const ClientForm(title: 'Add new client');
        });
  }
}
