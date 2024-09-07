// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/data/controllers/favorite/favorite.dart';
import 'package:day12_login/data/controllers/places/Places.dart';
import 'package:day12_login/screens/category/places/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowAllPlaces extends StatefulWidget {
  String id;
  ShowAllPlaces({Key? key, required this.id}) : super(key: key);

  @override
  State<ShowAllPlaces> createState() => _ShowAllPlacesState();
}

class _ShowAllPlacesState extends State<ShowAllPlaces> {
  @override
  void initState() {
    super.initState();
    _fetchPlaces();
  }

  Future<void> _fetchPlaces() async {
    final pro_Auth = Provider.of<Auth_Provider>(context, listen: false);
    final pro_Places = Provider.of<Places_Controller>(context, listen: false);

    setState(() {
      pro_Places.List_All_Places = null;
    });

    await pro_Places.fetch_Places(context, pro_Auth.user!.data!.token!, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer3<Auth_Provider, Places_Controller, Favorite_Controller>(
      builder: (context, pro_Auth, pro_Places, pro_Favorite, child) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(233, 235, 255, 1),
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //
                pro_Places.List_All_Places != null
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: pro_Places.List_All_Places!.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = pro_Places.List_All_Places![index];
                          return InkWell(
                            onTap: () {
                              pushNewScreen(context, Details_Screen(index_id: widget.id, show_id: item.id.toString()));
                            },
                            child: Container(
                              height: 120,
                              // width: size.width / 1.2,
                              margin: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: wtColor,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(color: Colors.black12, blurRadius: 30, spreadRadius: 10),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  pro_Auth.guest == 'akramaboubakersh@gmail.com'
                                      ? SizedBox()
                                      : IconButton(
                                          onPressed: () async {
                                            //

                                            await pro_Favorite.add_Favorite(context, pro_Auth.user!.data!.token!, item.id!.toString());

                                            if (pro_Places.List_All_Places![index].favorite == 1) {
                                              setState(() {
                                                pro_Places.List_All_Places![index].favorite = 0;
                                              });
                                            } else {
                                              setState(() {
                                                pro_Places.List_All_Places![index].favorite = 1;
                                              });
                                            }
                                          },
                                          icon: Card(
                                            color: wtColor,
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Icon(Icons.favorite,
                                                  color: pro_Places.List_All_Places![index].favorite == 0 ? gryColor : redColor),
                                            ),
                                          ),
                                        ),
                                  Row(
                                    children: [
                                      Text(
                                        item.name!,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: item.media.isEmpty ? "https://i.suar.me/ONn/l" : item.media[0].imgPath!,
                                          // height: 100,
                                          width: 130,
                                          fit: BoxFit.fill,
                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                              Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                          errorWidget: (context, url, error) => Center(child: Icon(Icons.error, size: 25)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      )),

                //
              ],
            ),
          ),
        );
      },
    );
  }
}
