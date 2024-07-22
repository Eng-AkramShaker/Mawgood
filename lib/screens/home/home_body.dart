import 'package:day12_login/controllers/auth/auth_provider.dart';
import 'package:day12_login/controllers/home/home_provider.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/core/services/category_api.dart';
import 'package:day12_login/screens/show_items/show_items.dart';
import 'package:day12_login/screens/widgets/app_bar_widget.dart';
import 'package:day12_login/screens/widgets/card_details.dart';
import 'package:day12_login/screens/widgets/category_list.dart';
import 'package:day12_login/screens/widgets/custom_slider.dart';
import 'package:day12_login/screens/widgets/dropdown_button/drop_down.dart';
import 'package:day12_login/screens/widgets/text_feild_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home_body_Screen extends StatefulWidget {
  const Home_body_Screen({super.key});

  @override
  State<Home_body_Screen> createState() => _HomeBodyScreenState();
}

class _HomeBodyScreenState extends State<Home_body_Screen> {
  final List<String> items = [
    'الدكاترة',
    'المطاعم',
    'الكافيهات',
    'الكمبيوتر',
    'الدكاترة',
    'المطاعم',
    'الكافيهات',
    'الكمبيوتر',
  ];

  @override
  void initState() {
    super.initState();
    intS();
  }

  intS() async {
    final home_Controller = Provider.of<Controller_Home>(context, listen: false);

    if (home_Controller.allCategories.isEmpty) {
      await home_Controller.fetch_Categories(context);

      await home_Controller.fetch_Items(context, '1');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer2<Auth_Provider, Controller_Home>(
      builder: (context, authProvider, home_Controller, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color.fromRGBO(233, 235, 255, 1),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildAppBar(authProvider),
                      const SizedBox(height: 1),
                      Divider(),
                      const SizedBox(height: 10),
                      home_Controller.isLodging == true
                          ? Column(
                              children: [
                                _buildSearchAndFilter(),
                                SizedBox(height: 14),
                                Custom_Slider(),
                                SizedBox(height: 14),
                                _buildCategoryList(home_Controller),
                                _buildProductGrid(home_Controller),
                              ],
                            )
                          : Center(child: Container(width: 25, height: 25, child: CircularProgressIndicator())),
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

  Widget _buildAppBar(Auth_Provider authProvider) {
    return AppBarWidget(name: authProvider.user?.data?.name ?? '');
  }

  Widget _buildSearchAndFilter() {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: Container(
              height: 40,
              child: const TextFeildWidget(),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Container(
          width: 130,
          height: 40,
          child: Drop_Down_Items(title: 'فلتر', Items: items),
        ),
      ],
    );
  }

  Widget _buildCategoryList(Controller_Home homeProvider) {
    return CategoryList(listCategories: homeProvider.allCategories);
  }

  Widget _buildProductGrid(Controller_Home homeProvider) {
    if (homeProvider.List_Product.isEmpty) {
      return SizedBox(
        width: 25,
        height: 25,
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
      return SizedBox(
        height: mediaheight(context),
        width: mediawidth(context),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: homeProvider.List_Product.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final item = homeProvider.List_Product[index];

            return homeProvider.Items_lodging == false
                ? Center(child: Container(width: 25, height: 25, child: CircularProgressIndicator()))
                : InkWell(
                    onTap: () {
                      //

                      pushNewScreen(
                          context,
                          Show_All_Items(
                              imageUrl: 'https://www.elmokattam.to-all.com/wp-content/uploads/2019/08/Internalmedicine_22_11zon.webp',
                              categoryName: 'عيادة الدكتور محمد'));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: CardDetails(name: item.name!, img: item.imgPath!),
                    ),
                  );
          },
        ),
      );
    }
  }
}
