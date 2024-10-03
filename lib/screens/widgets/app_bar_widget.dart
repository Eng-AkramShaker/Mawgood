// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/data/controllers/search/search_provider.dart';
import 'package:day12_login/screens/category/places/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AppBar AppBar_Widget({required BuildContext context, required bool? show_Search}) {
  return AppBar(
    title: show_Search == false ? const Text("") : const Text(""),
    actions: show_Search == true
        ? [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
            ),
          ]
        : null,
  );
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';

            pop(context);
          },
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => _buildSearchResults(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchResults(context);

  Widget _buildSearchResults(BuildContext context) {
    final pro_Auth = Provider.of<Auth_Provider>(context, listen: false);
    final pro_Search_Provider = Provider.of<Search_Provider>(context, listen: false);

    if (query.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        pro_Search_Provider.fetch_Search(context, pro_Auth.user!.data!.token!, query);
      });

      final results = pro_Search_Provider.dataSearch?.data.where((datum) {
        return datum.name!.toLowerCase().contains(query.toLowerCase());
      }).toList();

      if (results != null && results.isNotEmpty) {
        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final result = results[index];
            return ListTile(
              title: Text(result.name!),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Details_Screen(
                    index_id: result.category_id.toString(),
                    show_id: result.id.toString(),
                  ),
                ),
              ),
            );
          },
        );
      }
    }

    return const Center(child: Text('...  لا يوجد شيئ  '));
  }
}
