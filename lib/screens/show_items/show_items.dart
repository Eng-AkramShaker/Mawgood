import 'package:day12_login/screens/widgets/item_card.dart';
import 'package:flutter/material.dart';

class Show_All_Items extends StatefulWidget {
  final String imageUrl;
  final String categoryName;

  const Show_All_Items({Key? key, required this.imageUrl, required this.categoryName}) : super(key: key);

  @override
  State<Show_All_Items> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<Show_All_Items> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 235, 255, 1),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height,
                width: size.width,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ItemCard(context, imageUrl: widget.imageUrl, categoryName: widget.categoryName);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
