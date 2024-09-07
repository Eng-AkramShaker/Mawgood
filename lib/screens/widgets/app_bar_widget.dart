// ignore_for_file: must_be_immutable, unused_local_variable

import 'dart:async';
import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/data/controllers/drawer/drawer.dart';
import 'package:day12_login/data/controllers/search/search_provider.dart';
import 'package:day12_login/screens/widgets/text_field/widget_search.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AppBar AppBarWidget({
  required BuildContext context,
  required bool? show_Search,
}) {
  final pro_Auth = Provider.of<Auth_Provider>(context, listen: false);
  final myDrawerController = Provider.of<MyDrawerController>(context, listen: false);
  final pro_Search = Provider.of<Search_Provider>(context, listen: false);
  Size size = MediaQuery.of(context).size;

  return AppBar(
    backgroundColor: wtColor,
    // title: Directionality(
    //   textDirection: TextDirection.rtl,
    // child: Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     // الشعار
    //     Container(
    //       height: 50,
    //       width: 100,
    //       decoration: BoxDecoration(
    //         color: Colors.transparent,
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       child: Image.asset('assets/images/logo.png'),
    //     ),

    //     Expanded(
    //       child: SizedBox(
    //         height: 50,
    //         child: EasySearchBar(
    //           backgroundColor: wtColor,
    //           title: SizedBox(),
    //           onSearch: (value) {
    //             if (pro_Search.dataSearch != null && pro_Search.dataSearch!.data.isNotEmpty) {
    //               pro_Search.dataSearch!.data[0].name = value;
    //             }
    //           },
    //           asyncSuggestions: (value) async {
    //             final result = await pro_Search.fetch_Search(
    //               context,
    //               pro_Auth.user!.data!.token!,
    //               value,
    //             );
    //             if (pro_Search.dataSearch != null) {
    //               return pro_Search.dataSearch!.data.map((datum) => datum.name.toString()).toList();
    //             } else {
    //               return [];
    //             }
    //           },
    //         ),
    //       ),
    //     ),
    //   ],
    // ),
    // ),
  );
}

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
          Container(
            height: 35,
            child: Search(
              controller: searchProvider.search_Text_controller,
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () async {
                  await searchProvider.fetch_Search(context, pro_Auth.user!.data!.token!, value);
                  searchProvider.updateSearchText.text = value;
                  print(searchProvider.updateSearchText.text);
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          Container(
            // height: 40.h,
            // width: 15.w,
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
                    child: Expanded(
                      child: Card(
                        child: Container(
                          width: double.infinity,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item?.name ?? '',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ));
              },
            ),
          ),
        ],
      );
    });
  }
}
