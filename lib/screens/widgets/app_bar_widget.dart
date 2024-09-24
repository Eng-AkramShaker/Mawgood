// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/data/controllers/drawer/drawer.dart';
import 'package:day12_login/data/controllers/search/search_provider.dart';
import 'package:day12_login/data/model/Search_Model.dart';
import 'package:day12_login/screens/category/places/details_screen.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AppBarWidget({required BuildContext context, required bool? show_Search}) {
  final pro_Auth = Provider.of<Auth_Provider>(context, listen: false);
  final myDrawerController = Provider.of<MyDrawerController>(context, listen: false);
  final pro_Search_Provider = Provider.of<Search_Provider>(context, listen: false);
  Size size = MediaQuery.of(context).size;

  return show_Search == false
      ? AppBar()
      : EasySearchBar(
          backgroundColor: Colors.white,
          searchBackgroundColor: Colors.white,
          title: SizedBox(),
          onSearch: (value) async {
            final searchValue = value.trim();
            print("Searching for: '$searchValue'");

            if (searchValue.isNotEmpty) {
              // Perform the search
              await pro_Search_Provider.fetch_Search(context, pro_Auth.user!.data!.token!, searchValue);

              // Debug: Check if dataSearch is updated
              if (pro_Search_Provider.dataSearch != null) {
                print("DataSearch updated: ${pro_Search_Provider.dataSearch!.data.length} items found");
              } else {
                print("DataSearch is null after fetching.");
              }
            } else {
              print("Search value is empty.");
            }
          },
          asyncSuggestions: (value) async {
            final searchValue = value.trim();
            if (searchValue.isNotEmpty) {
              await pro_Search_Provider.fetch_Search(context, pro_Auth.user!.data!.token!, searchValue);

              if (pro_Search_Provider.dataSearch != null) {
                return pro_Search_Provider.dataSearch!.data.map((datum) => datum.name.toString()).toSet().toList();
              } else {
                return [];
              }
            } else {
              return [];
            }
          },
          onSuggestionTap: (suggestion) async {
            print("Suggestion tapped: $suggestion");

            if (pro_Search_Provider.dataSearch != null) {
              final selectedDatum = pro_Search_Provider.dataSearch!.data.firstWhere(
                (datum) => datum.name.toString() == suggestion,
                orElse: () => Datum(
                  id: null,
                  views: [],
                  name: '',
                  address: '',
                  description: '',
                  lat: 0.0,
                  lng: 0.0,
                  category: '',
                  category_id: '',
                  favorite: false,
                  media: [],
                  reviews: [],
                  rating: 0.0,
                  avgRating: 0.0,
                ),
              );

              String categoryId = selectedDatum.category_id.toString();
              String showId = selectedDatum.id.toString();

              print("======================Category ID: $categoryId");
              print("======================Show ID: $showId");

              // Navigate to the details screen
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Details_Screen(index_id: categoryId, show_id: showId),
                ),
              );

              // Optionally clear search results
              pro_Search_Provider.dataSearch = null;
            } else {
              print("No data available for suggestions.");
            }
          },
        );
}
