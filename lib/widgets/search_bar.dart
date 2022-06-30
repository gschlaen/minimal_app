import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:minimal_app/providers/providers.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientsProvider>(context);
    final searchBarProvider = Provider.of<SearchBarProvider>(context);

    return Expanded(
      child: Container(
        height: 36,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: StadiumBorder(side: BorderSide(color: Colors.grey[500]!)),
        ),
        child: TextField(
          autocorrect: false,
          keyboardType: TextInputType.text,
          controller: _controller,
          onChanged: (value) {
            searchBarProvider.textLength = value.length;
          },
          onSubmitted: (value) {
            if (value.isEmpty) {
              clientsProvider.limit = 5;
              clientsProvider.loadClients();
              return;
            }
            clientsProvider.searchByQuery(value);
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: const TextStyle(fontSize: 13),
            prefixIcon: const Icon(Icons.search, size: 20),
            suffixIcon: searchBarProvider.textLength > 0
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    color: Colors.grey,
                    onPressed: () {
                      _controller.text = '';
                      searchBarProvider.textLength = 0;
                    },
                  )
                : const SizedBox(),
            contentPadding: const EdgeInsets.only(),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
