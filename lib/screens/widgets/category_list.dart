import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  CategoryList({super.key});
  final List<Map<String, String>> categories = [
    {'image': 'assets/images/man.png', 'title': 'Man'},
    {'image': 'assets/images/woman (1).png', 'title': 'Woman'},
    {'image': 'assets/images/pets 1.png', 'title': 'Pets'},
    {'image': 'assets/images/child.png', 'title': 'Child'},
    {'image': 'assets/images/all.png', 'title': 'All'},
    {'image': 'assets/images/man.png', 'title': 'Man'},
    {'image': 'assets/images/woman (1).png', 'title': 'Woman'},
    {'image': 'assets/images/pets 1.png', 'title': 'Pets'},
    {'image': 'assets/images/man.png', 'title': 'Man'},
    {'image': 'assets/images/woman (1).png', 'title': 'Woman'},
    {'image': 'assets/images/pets 1.png', 'title': 'Pets'},
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 100.0,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: categories.map((category) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 80.0,
                          width: 80.0,
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  category['image']!,
                                  height: 25.0,
                                  width: 25.0,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  category['title']!,
                                  style: const TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(height: 8.0),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
