import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/data/controllers/favorite/favorite.dart';
import 'package:day12_login/data/controllers/home/home_provider.dart';
import 'package:day12_login/data/controllers/places/Places.dart';
import 'package:day12_login/data/controllers/profile/profile_provider.dart';
import 'package:day12_login/screens/widgets/drawer/custom_drawe.dart';
import 'package:day12_login/screens/category/places/details_screen.dart';
import 'package:day12_login/screens/favorite/widget/item_card.dart';
import 'package:day12_login/screens/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorite_Screen extends StatefulWidget {
  const Favorite_Screen({super.key});

  @override
  State<Favorite_Screen> createState() => _Favorite_ScreenState();
}

class _Favorite_ScreenState extends State<Favorite_Screen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer5<Auth_Provider, Controller_Home, Profile_Provider, Favorite_Controller, Places_Controller>(
      builder: (context, pro_Auth, pro_home, pro_Profile, pro_Favorite, pro_Places, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color.fromRGBO(233, 235, 255, 1),
            appBar: AppBarWidget(context: context, show_Search: false),
            drawer: Custom_Drawer(),
            body: SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      pro_Profile.is_loading == true
                          ? Center(child: Container(width: 25, height: 25, child: CircularProgressIndicator()))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: pro_Profile.List_Favorite.length,
                              itemBuilder: (context, index) {
                                final item = pro_Profile.List_Favorite[index];

                                return Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: InkWell(
                                    onTap: () {
                                      //
                                      print(item.place!.categoryId);
                                      print(item.place!.id);

                                      // print(show_id);

                                      pushNewScreen(
                                        context,
                                        Details_Screen(
                                          index_id: item.place!.categoryId.toString(),
                                          show_id: item.place!.id.toString(),
                                        ),
                                      );
                                    },
                                    child: custom_item(
                                      context,
                                      List_Favorite: pro_Profile.List_Favorite[index],
                                      onPressed: () async {
                                        await pro_Favorite.delete_Favorite(
                                          context,
                                          pro_Profile,
                                          pro_Auth.user!.data!.token.toString(),
                                          pro_Profile.List_Favorite[index].placeId.toString(),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                      SizedBox(height: 50),
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
}
