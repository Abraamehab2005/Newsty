

import 'package:flutter/material.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/features/home/components/news_item.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Categories",
          style: TextStyle(
            fontSize: AppSize.sp16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF141414),
          ),
        ),
      ),
      body: Consumer<HomeController>(
        builder:
            (BuildContext context, HomeController controller, Widget? child) {
              return Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(
                      left: AppSize.pw16,
                      top: AppSize.ph16,
                      bottom: AppSize.ph16,
                    ),
                    child: SizedBox(
                      height: AppSize.ph35,
                      child: ListView.separated(
                        padding: EdgeInsets.only(right: AppSize.pw16),
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          bool isSelected =
                              categories[index] == controller.selectedCategory;
                          return GestureDetector(
                            onTap: () {
                              controller.updateSelectedCategory(
                                categories[index],
                              );
                            },
                            child: IntrinsicWidth(
                              child: Column(
                                children: [
                                  Text(
                                    categories[index][0].toUpperCase() +
                                        categories[index].substring(1),
                                    style: TextStyle(
                                      color: Color(0xFF363636),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  if (isSelected) ...[
                                    SizedBox(height: AppSize.ph6),
                                    Container(
                                      height: AppSize.h2,
                                      color: LightColors.primaryColor,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: AppSize.pw12);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.newsTopHeadLineList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final model = controller.newsTopHeadLineList[index];
                        return NewsItem(model: model);
                      },
                    ),
                  ),
                ],
              );
            },
      ),
    );
  }
}

final List<String> categories = [
  "business",
  "entertainment",
  "general",
  "health",
  "science",
  "sports",
  "technology",
];
