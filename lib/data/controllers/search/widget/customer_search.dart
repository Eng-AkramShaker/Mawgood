// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/data/controllers/search/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchCustomer extends StatefulWidget {
  const SearchCustomer({Key? key}) : super(key: key);

  @override
  _SearchCustomerState createState() => _SearchCustomerState();
}

class _SearchCustomerState extends State<SearchCustomer> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer2<Auth_Provider, Search_Provider>(builder: (context, pro_Auth, searchProvider, child) {
      return Column(
        children: [
          TextField(
            controller: searchProvider.search_Text_controller,
            decoration: InputDecoration(
              hintText: 'Enter your search query',
              fillColor: wtColor,
            ),
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () async {
                await searchProvider.fetch_Search(context, pro_Auth.user!.data!.token!, searchProvider.search_Text_controller.text);
                searchProvider.updateSearchText.text = value;
                print(searchProvider.updateSearchText.text);
              });
            },
          ),
          const SizedBox(height: 10),
          Container(
            height: 40.h,
            width: 20.w,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: searchProvider.dataSearch?.data.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final item = searchProvider.dataSearch?.data[index];

                if (searchProvider.search_Text_controller.text.isNotEmpty &&
                    !item!.name.toString().contains(searchProvider.search_Text_controller.text)) {
                  return const SizedBox.shrink();
                }

                return InkWell(
                  onTap: () {
                    searchProvider.search_Text_controller.text = item?.name.toString() ?? '';
                    print(item?.name);
                    pop(context);
                  },
                  child: ListTile(
                    title: Center(
                      child: Text(
                        item?.name ?? '',
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
