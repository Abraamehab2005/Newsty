import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/extentions/date_time_extenion.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/core/widgets/custom_svg_picture.dart';
import 'package:news_app/features/details/news_details_screen.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.model});
  final NewsArticleModel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return NewsDetailsScreen(model: model);
            },
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.pw16, vertical: AppSize.ph8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.r8),
              child: CustomCachedNetworkImage(imagePath: model.urlToImage ?? ""),
            ),
            SizedBox(width: AppSize.pw8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title.toString(),
                    style: TextStyle(
                      fontSize: AppSize.sp16,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: AppSize.r10,
                        backgroundImage: NetworkImage(model.urlToImage ?? ""),
                      ),
                      SizedBox(width: AppSize.pw8),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              (model.author ?? "").substring(
                                0,
                                min((model.author ?? "").length, 10),
                              ),
                              style: TextStyle(
                                fontSize: AppSize.sp12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF141414),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: AppSize.pw8),
                            Expanded(
                              child: Text(
                                model.publishedAt.formatDateTime(),
                                style: TextStyle(
                                  fontSize: AppSize.sp12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF141414),
                                ),
                              ),
                            ),
                            CustomSvgPicture.withoutColor(
                              path: 'assets/images/bookmark.svg',
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
      ),
    );
  }
}
