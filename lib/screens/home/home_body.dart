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
import 'package:day12_login/data/model/Search_Model.dart';
import 'package:day12_login/data/off_Line_DB/hive_providers/hive_user.dart';
import 'package:day12_login/data/services/search_api.dart';
import 'package:day12_login/screens/category/places/details_screen.dart';
import 'package:day12_login/screens/widgets/drawer/custom_drawe.dart';
import 'package:day12_login/screens/category/places/places_items.dart';
import 'package:day12_login/screens/widgets/card_details.dart';
import 'package:day12_login/screens/widgets/category_list.dart';
import 'package:day12_login/screens/widgets/sliders/auto_slider.dart';
import 'package:day12_login/screens/widgets/sliders/custom_slider.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
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

    print('=========================: ${pro_Auth.user!.data!.token!.toString()}');

    if (home_Controller.allCategories.isEmpty) {
      await pro_Profile.fetch_Profile(context, pro_Favorite, pro_Auth.user!.data!.token!);
      await home_Controller.fetch_sliders(context, pro_Auth.user!.data!.token!);
      await home_Controller.fetch_Categories(context);

      home_Controller.fetch_Items(context, '1');
      pro_Privacy_About.fetch_Privacy_About(context, pro_Auth.user!.data!.token!);
    }
  }

  // String searchValue = '';
  // final List<String> _suggestions = [];

  // Future<List<String>> _fetchSuggestions(String searchValue) async {
  //   await Future.delayed(const Duration(milliseconds: 750));

  //   return _suggestions.where((element) {
  //     return element.toLowerCase().contains(searchValue.toLowerCase());
  //   }).toList();
  // }

  TextEditingController _searchController = TextEditingController();
  bool _isNavigating = false; // Flag to prevent repeated navigation

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
    Size size = MediaQuery.of(context).size;

    return Consumer6<Auth_Provider, Controller_Home, Profile_Provider, Favorite_Controller, Search_Provider, Places_Controller>(
      builder: (context, pro_Auth, pro_home, pro_Profile, pro_Favorite, pro_Search_Provider, pro_Places_Provider, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: secondaryColor,
            // appBar: AppBarWidget(context: context, show_Search: false),

            appBar: EasySearchBar(
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
            ),
            drawer: Custom_Drawer(),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //
                      pro_home.isLodging == true
                          ? Column(
                              children: [
                                Auto_Slider(context, pro_home.itemList),
                                SizedBox(height: 14),
                                _buildCategoryList(pro_home),
                                _buildProductGrid(pro_home, pro_Favorite),
                              ],
                            )
                          : Center(
                              child: Container(width: 25, height: 25, child: CircularProgressIndicator()),
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
      return const SizedBox(
        width: 25,
        height: 25,
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
      return SizedBox(
        height: mediaheight(context),
        width: mediawidth(context),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: (homeProvider.List_Product.length / 2).ceil(),
          itemBuilder: (context, index) {
            final item1 = homeProvider.List_Product[index * 2];
            final item2 = (index * 2 + 1 < homeProvider.List_Product.length) ? homeProvider.List_Product[index * 2 + 1] : null;
            print(homeProvider.List_Product.length);
            return Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          //

                          pushNewScreen(context, ShowAllPlaces(id: item1.id.toString()));
                        },
                        child: CardDetails(name: item1.name!, img: item1.imgPath!)),
                  ),
                  if (item2 != null) SizedBox(width: 10),
                  if (item2 != null)
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            //

                            pushNewScreen(context, ShowAllPlaces(id: item2.id.toString()));
                          },
                          child: CardDetails(name: item2.name!, img: item2.imgPath!)),
                    )
                  else
                    Spacer(),
                ],
              ),
            );
          },
        ),
      );
    }
  }
}

//

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String searchValue = '';
  final List<String> _suggestions = [
    'Afeganistan',
    'Albania',
    'Algeria',
    'Australia',
    'Brazil',
    'German',
    'Madagascar',
    'Mozambique',
    'Portugal',
    'Zambia'
  ];

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));

    return _suggestions.where((element) {
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Example',
        theme: ThemeData(primarySwatch: Colors.orange),
        home: Scaffold(
            appBar: EasySearchBar(
                title: const Text(' '),
                onSearch: (value) => setState(() => searchValue = value),
                asyncSuggestions: (value) async => await _fetchSuggestions(value)),
            body: Center(child: Text('Value: $searchValue'))));
  }
}

// class Custom_Drawer extends StatelessWidget {
//   const Custom_Drawer({
//     super.key,
//   });
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SizedBox(
//       width: size.width / 1.3,
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: Colors.grey,
//           body: SidebarDrawer(
//             drawer: const Scaffold(),
//             body: Padding(
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   /// Header of the Drawer
//                   Material(
//                     color: Colors.blueAccent,
//                     child: InkWell(
//                       onTap: () {
//                         /// Close Navigation drawer before
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 24),
//                         child: Column(
//                           children: const [
//                             CircleAvatar(
//                               radius: 52,
//                               backgroundImage: NetworkImage(
//                                   'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHNtaWx5JTIwZmFjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'
//                                   // 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c21pbHklMjBmYWNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60'
//                                   ),
//                             ),
//                             SizedBox(
//                               height: 12,
//                             ),
//                             Text(
//                               'Sophia',
//                               style: TextStyle(fontSize: 28, color: Colors.white),
//                             ),
//                             const Text(
//                               '@sophia.com',
//                               style: TextStyle(fontSize: 14, color: Colors.white),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   /// Header Menu items
//                   Column(
//                     children: [
//                       ListTile(
//                         leading: Icon(Icons.home_outlined),
//                         title: Text('Home'),
//                         onTap: () {
//                           /// Close Navigation drawer before
//                           Navigator.pop(context);
//                         },
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.favorite_border),
//                         title: Text('Favourites'),
//                         onTap: () {
//                           /// Close Navigation drawer before
//                           Navigator.pop(context);
//                         },
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.workspaces),
//                         title: Text('Workflow'),
//                         onTap: () {},
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.update),
//                         title: Text('Updates'),
//                         onTap: () {},
//                       ),
//                       const Divider(
//                         color: Colors.black45,
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.account_tree_outlined),
//                         title: Text('Plugins'),
//                         onTap: () {},
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.notifications_outlined),
//                         title: Text('Notifications'),
//                         onTap: () {},
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
