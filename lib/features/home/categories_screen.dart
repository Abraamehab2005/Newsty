import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/extentions/date_time_extenion.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
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
            fontSize: 16,
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
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 16,
                      bottom: 16,
                    ),
                    child: SizedBox(
                      height: 35,
                      child: ListView.separated(
                        padding: EdgeInsets.only(right: 16),
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
                                    SizedBox(height: 6),
                                    Container(
                                      height: 2,
                                      color: LightColors.primaryColor,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: 12);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.newsTopHeadLineList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final model = controller.newsTopHeadLineList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CustomCachedNetworkImage(
                                  imagePath: model.urlToImage ?? "",
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model.title.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 2,
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundImage: NetworkImage(
                                            model.urlToImage ?? "",
                                          ),
                                        ),
                                        SizedBox(width: 6),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text(
                                                (model.author ?? "").substring(
                                                  0,
                                                  min(
                                                    (model.author ?? "").length,
                                                    10,
                                                  ),
                                                ),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF141414),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                model.publishedAt
                                                    .formatDateTime(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF141414),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
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
