import 'package:day12_login/data/controllers/home/home_provider.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/data/model/all_category_model.dart';
import 'package:day12_login/screens/category/all_show_category.dart';
import 'package:day12_login/screens/widgets/images/Custom_Image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key, required this.listCategories});
  final List<Datum> listCategories;

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Controller_Home>(
      builder: (context, proHome, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildCategoryList(proHome),
            const SizedBox(height: 16.0),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'الفئات',
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            //

            pushNewScreen(context, All_Show_Category_Screen(List_items: widget.listCategories));
          },
          child: Text(
            'الكل',
            style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                // decoration: TextDecoration.underline,
                decorationThickness: 2.0,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget _buildCategoryList(Controller_Home proHome) {
    return SizedBox(
      height: 160.0,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.listCategories.length,
        itemBuilder: (context, index) {
          final category = widget.listCategories[index];
          return _buildCategoryItem(category, proHome);
        },
      ),
    );
  }

  Widget _buildCategoryItem(Datum category, Controller_Home proHome) {
    return InkWell(
      onTap: () {
        proHome.fetch_Items(context, category.id.toString());
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 220.0,
          width: 200.0,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              children: [
                // CachedNetworkImage(
                //   imageUrl: category.imgPath!,
                //   width: 70,
                //   height: 60,
                //   fit: BoxFit.fill,
                //   progressIndicatorBuilder: (context, url, downloadProgress) =>
                //       Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                //   errorWidget: (context, url, error) => Center(child: Icon(Icons.error, size: 25)),
                // ),

                Custom_Image(h: 80, w: 80, images: category.imgPath!),

                const SizedBox(height: 8.0),
                Text(
                  category.name!,
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
