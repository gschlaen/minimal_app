import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:minimal_app/providers/providers.dart';
import 'package:minimal_app/themes/app_theme.dart';
import 'package:minimal_app/widgets/widgets.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientsProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ClientsBackground(
        child: SafeArea(
          child: RefreshIndicator(
            color: AppTheme.primary,
            onRefresh: () async {
              await clientsProvider.loadClients();
            },
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const _CustomAppBar(),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const _Header(),
                          Row(
                            children: const [
                              SearchBar(),
                              SizedBox(width: 15),
                              AddNewButton(),
                            ],
                          ),
                          const _ClientsBody(),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: BlackButton(
                              text: 'LOAD MORE',
                              onPressed: (clientsProvider.limit >= clientsProvider.total) | clientsProvider.isSearchByQuery
                                  ? null
                                  : () {
                                      clientsProvider.limit += 5;
                                      clientsProvider.loadClients();
                                    },
                            ),
                          ),
                          const SizedBox(height: 36),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return SliverAppBar(
      floating: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          icon: const Icon(Icons.login_outlined, color: AppTheme.primary),
          onPressed: () {
            authProvider.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Image(image: AssetImage('assets/logo.png'), width: 129),
        SizedBox(height: 18),
        SizedBox(
            width: double.infinity,
            child: Text('CLIENTS',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1), textAlign: TextAlign.start)),
        SizedBox(height: 24),
      ],
    );
  }
}

class _ClientsBody extends StatelessWidget {
  const _ClientsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientsProvider>(context);

    return Column(
      children: [
        const SizedBox(height: 18),
        clientsProvider.clients.isEmpty && clientsProvider.isLoading
            ? const SizedBox(
                width: double.infinity,
                height: 500,
                child: Center(
                  child: CircularProgressIndicator(color: AppTheme.primary),
                ),
              )
            : clientsProvider.clients.isEmpty && !clientsProvider.isLoading
                ? const SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Center(
                      child: Text('No matches were found', style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w400)),
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: clientsProvider.clients.length,
                    itemBuilder: (context, index) {
                      final client = clientsProvider.clients[index];
                      return ClientCard(client: client);
                    },
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 16)),
        const SizedBox(height: 24),
      ],
    );
  }
}
