// ignore_for_file: deprecated_member_use, unused_element

import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/data/controllers/favorite/favorite.dart';
import 'package:day12_login/data/controllers/places/Places.dart';
import 'package:day12_login/screens/widgets/containers/empty.dart';
import 'package:day12_login/screens/widgets/sliders/custom_slider.dart';
import 'package:day12_login/screens/widgets/texts/custom_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rating_summary/rating_summary.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class Details_Screen extends StatefulWidget {
  final String index_id;
  final String show_id;

  Details_Screen({Key? key, required this.index_id, required this.show_id}) : super(key: key);

  @override
  State<Details_Screen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<Details_Screen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabs = ['أرقام الهاتف', 'الخريطة', 'الروابط'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _fetchOneItem();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchOneItem() async {
    final authProvider = Provider.of<Auth_Provider>(context, listen: false);
    final placesProvider = Provider.of<Places_Controller>(context, listen: false);

    placesProvider.one_item = null;

    await placesProvider.fetch_one_item(context, authProvider.user!.data!.token!, widget.index_id, widget.show_id);
  }

  List<Widget> _buildItemList(Places_Controller placesProvider) {
    if (placesProvider.one_item == null) {
      return [_buildPlaceholderImage()];
    }

    return placesProvider.one_item!.data!.media.map((media) {
      return GestureDetector(
        onTap: () => _showImageDialog(media.imgPath),
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Image.network(media.imgPath!, fit: BoxFit.fill),
        ),
      );
    }).toList();
  }

  void _showImageDialog(String? imagePath) {
    if (imagePath != null) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(imagePath, fit: BoxFit.fill),
            ),
          );
        },
      );
    } else {
      print("Image path is null or invalid");
    }
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Image.network('https://i.suar.me/ONn/l', fit: BoxFit.fill),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Consumer3<Auth_Provider, Places_Controller, Favorite_Controller>(
          builder: (context, authProvider, placesProvider, favoriteProvider, child) {
            return Scaffold(
              backgroundColor: const Color.fromRGBO(233, 235, 255, 1),
              appBar: AppBar(
                title: Custom_Text(text: '', size: 20),
              ),
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      placesProvider.is_loading
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Column(
                              children: [
                                Custom_Slider(context, _buildItemList(placesProvider)),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: _buildDetailsContent(authProvider, placesProvider, size),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDetailsContent(Auth_Provider authProvider, Places_Controller placesProvider, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Custom_Text(text: placesProvider.one_item!.data!.name, size: 25, color: bluColor),
        SizedBox(height: 10),
        _buildViewRow(placesProvider),
        SizedBox(height: 20),
        _buildCategoryRow(placesProvider),
        SizedBox(height: 20),
        if (placesProvider.one_item!.data!.address != '') _buildAddressRow(placesProvider),
        SizedBox(height: 20),
        _buildDescriptionRow(placesProvider),
        SizedBox(height: 10),
        if (authProvider.guest != 'akramaboubakersh@gmail.com') _buildStarRating(show_id: widget.show_id),
        SizedBox(height: 10),
        _buildRatingSummary(placesProvider),
        SizedBox(height: 10),
        _buildTabSection(placesProvider, size),
      ],
    );
  }

  Widget _buildViewRow(Places_Controller placesProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.remove_red_eye, color: bluColor),
            SizedBox(width: 4),
            Custom_Text(text: '  ${placesProvider.one_item!.data!.views} مشاهدة', size: 15),
          ],
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget _buildCategoryRow(Places_Controller placesProvider) {
    return Row(
      children: [
        Icon(Icons.folder_open, color: bluColor),
        Custom_Text(text: '   التصنيفات:  ', size: 15),
        Custom_Text(text: placesProvider.one_item!.data!.category, color: bluColor, size: 18),
      ],
    );
  }

  Widget _buildAddressRow(Places_Controller placesProvider) {
    Size size = MediaQuery.of(context).size;
    final allAddressesInOneLine = placesProvider.one_item!.data!.address.map((address) => address.address).join(' \n\n ');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.location_on, color: bluColor),
        SizedBox(width: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Custom_Text(text: 'العنوان:  ', size: 15),
            Container(width: size.width / 1.5, child: Text('$allAddressesInOneLine', style: TextStyle(fontSize: 15))),
          ],
        ),
      ],
    );
  }

  Widget _buildDescriptionRow(Places_Controller placesProvider) {
    Size size = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.description, color: bluColor),
        SizedBox(width: 4),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Custom_Text(text: 'الوصف: ', size: 15),
              Container(
                width: size.width / 1.5,
                child: Text('${placesProvider.one_item!.data!.description}', style: TextStyle(fontSize: 15)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSummary(Places_Controller placesProvider) {
    return container_Empty(
      h: 150,
      w: double.infinity,
      color: wtColor,
      Padding: 5,
      border: true,
      child: Center(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: RatingSummary(
            counter: placesProvider.ReviewCount,
            average: placesProvider.parseAvgRating(placesProvider.one_item!.data!.avgRating),
            showAverage: true,
            counterOneStars: 1,
            counterTwoStars: 1,
            counterThreeStars: 2,
            counterFourStars: 4,
            counterFiveStars: 5,
          ),
        ),
      ),
    );
  }

  Widget _buildTabSection(Places_Controller placesProvider, Size size) {
    return Container(
      width: 100.w,
      child: Column(
        children: [
          SizedBox(height: 5.w),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.red,
            tabs: tabs.map((tabText) => Tab(child: Custom_Text(text: tabText, size: 18), height: 50)).toList(),
          ),
          SizedBox(
            height: 300,
            width: size.width,
            child: TabBarView(
              controller: _tabController,
              children: tabs.map((tabText) => _buildTabContent(placesProvider, tabText, size)).toList(),
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildTabContent(Places_Controller placesProvider, String tabText, Size size) {
    switch (tabText) {
      case 'أرقام الهاتف':
        return _buildPhoneNumbersTab(placesProvider);
      case 'الخريطة':
        return _buildMapTab(placesProvider);
      case 'الروابط':
        return _buildLinksTab(placesProvider, size);
      default:
        return Center(child: Custom_Text(text: tabText, size: 18));
    }
  }

  Widget _buildPhoneNumbersTab(Places_Controller placesProvider) {
    return Column(
      children: [
        SizedBox(height: 30),
        for (final phone in placesProvider.one_item!.data!.contacts)
          GestureDetector(
            onTap: () => launch("tel://${phone.phone}"),
            child: Container(
              height: 7.h,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(8),
                color: wtColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Custom_Text(text: phone.phone!, size: 18, color: bluColor),
                  Icon(Icons.phone, color: Colors.black),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMapTab(Places_Controller placesProvider) {
    final location = LatLng(
      double.parse(placesProvider.one_item!.data!.lat.toString()),
      double.parse(placesProvider.one_item!.data!.lng.toString()),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(target: location, zoom: 14),
        markers: {Marker(markerId: MarkerId('locationMarker'), position: location)},
        zoomGesturesEnabled: true,
        scrollGesturesEnabled: true,
        tiltGesturesEnabled: true,
        rotateGesturesEnabled: true,
        compassEnabled: true,
        mapType: MapType.normal,
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        },
      ),
    );
  }

  Widget _buildLinksTab(Places_Controller placesProvider, Size size) {
    return ListView.builder(
      itemCount: placesProvider.one_item!.data!.links.length,
      itemBuilder: (context, index) {
        final link = placesProvider.one_item!.data!.links[index];
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: GestureDetector(
            onTap: () => launch(link.link.toString()),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(8),
                color: wtColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: size.width / 1.4, child: Custom_Text(text: link.link!, size: 18, color: bluColor)),
                    Icon(Icons.link, color: Colors.black),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStarRating({required show_id}) {
    double _currentRating = 0;

    return Consumer3<Auth_Provider, Places_Controller, Favorite_Controller>(
      builder: (context, pro_Auth, pro_Places, pro_Favorite, child) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: RatingBar.builder(
              initialRating: _currentRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                setState(() {
                  _currentRating = rating;
                });

                pro_Places.Send_Rating(context, pro_Auth.user!.data!.token!, widget.index_id, widget.show_id, '$_currentRating');
                print("New Rating: $rating");
              },
            ),
          ),
        );
      },
    );
  }
}
