import 'package:algov/app/routes.dart';
import 'package:algov/core/utils/constants/constant.dart';
import 'package:algov/ui/widgets/app_widgets/custom_grid.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          return CustomGrid(
            color: categories[index]['color'],
            icon: categories[index]['icon'],
            path: categories[index]['path'],
            title: categories[index]['title'],
            isgrid: false,
            animType: AnimType.slide,
          );
        },
      ),
    );
  }
}
