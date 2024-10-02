// ignore_for_file: unused_local_variable, unused_element

import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/data/controllers/favorite/favorite.dart';
import 'package:day12_login/data/controllers/home/home_provider.dart';
import 'package:day12_login/data/controllers/places/Places.dart';
import 'package:day12_login/data/controllers/privacy_about/privacy_about.dart';
import 'package:day12_login/data/controllers/profile/profile_provider.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/data/controllers/search/search_provider.dart';
import 'package:day12_login/screens/widgets/app_bar_widget.dart';
import 'package:day12_login/screens/widgets/drawer/custom_drawe.dart';
import 'package:day12_login/screens/category/places/places_items.dart';
import 'package:day12_login/screens/category/widget/card_details.dart';
import 'package:day12_login/screens/category/widget/category_list.dart';
import 'package:day12_login/screens/widgets/sliders/auto_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home_body_Screen extends StatefulWidget {
  const Home_body_Screen({super.key});

  @override
  State<Home_body_Screen> createState() => _HomeBodyScreenState();
}

class _HomeBodyScreenState extends State<Home_body_Screen> {
  @override
  void initState() {
    super.initState();
    intS();
  }

  intS() async {
    final home_Controller = Provider.of<Controller_Home>(context, listen: false);
    final pro_Auth = Provider.of<Auth_Provider>(context, listen: false);
    final pro_Profile = Provider.of<Profile_Provider>(context, listen: false);
    final pro_Favorite = Provider.of<Favorite_Controller>(context, listen: false);
    final pro_Privacy_About = Provider.of<Privacy_About_Controller>(context, listen: false);

    if (home_Controller.allCategories.isEmpty) {
      await pro_Profile.fetch_Profile(context, pro_Auth.user!.data!.token!);
      await home_Controller.fetch_sliders(context, pro_Auth.user!.data!.token!);
      await home_Controller.fetch_Categories(context);

      home_Controller.fetch_Items(context, '1');
      pro_Privacy_About.fetch_Privacy_About(context, pro_Auth.user!.data!.token!);
    }
  }

  TextEditingController _searchController = TextEditingController();
  // ignore: unused_field
  bool _isNavigating = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _resetSearch() {
    _searchController.clear();
    setState(() {
      _isNavigating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer6<Auth_Provider, Controller_Home, Profile_Provider, Favorite_Controller, Search_Provider, Places_Controller>(
      builder: (context, pro_Auth, pro_home, pro_Profile, pro_Favorite, pro_Search_Provider, pro_Places_Provider, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: secondaryColor,
            appBar: AppBar_Widget(context: context, show_Search: true),
            drawer: Custom_Drawer(),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      pro_home.isLodging
                          ? Column(
                              children: [
                                Auto_Slider(context, pro_home.itemList),
                                const SizedBox(height: 14),
                                _buildCategoryList(pro_home),
                                _buildProductGrid(pro_home, pro_Favorite),
                                const SizedBox(height: 30),
                              ],
                            )
                          : const Center(
                              child: SizedBox(width: 25, height: 25, child: CircularProgressIndicator()),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryList(Controller_Home homeProvider) {
    return CategoryList(listCategories: homeProvider.allCategories);
  }

  Widget _buildProductGrid(Controller_Home homeProvider, Favorite_Controller pro_Favorite) {
    if (homeProvider.List_Product.isEmpty) {
      return const SizedBox(width: 25, height: 25, child: Center(child: CircularProgressIndicator()));
    } else {
      return Column(
        children: List.generate(
          (homeProvider.List_Product.length / 2).ceil(),
          (index) {
            final item1 = homeProvider.List_Product[index * 2];
            final item2 = (index * 2 + 1 < homeProvider.List_Product.length) ? homeProvider.List_Product[index * 2 + 1] : null;

            return Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        pushNewScreen(context, ShowAllPlaces(id: item1.id.toString()));
                      },
                      child: CardDetails(name: item1.name!, img: item1.imgPath!),
                    ),
                  ),
                  if (item2 != null) const SizedBox(width: 10),
                  if (item2 != null)
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          pushNewScreen(context, ShowAllPlaces(id: item2.id.toString()));
                        },
                        child: CardDetails(name: item2.name!, img: item2.imgPath!),
                      ),
                    ),
                  if (item2 == null) const Spacer(),
                ],
              ),
            );
          },
        ),
      );
    }
  }
}
