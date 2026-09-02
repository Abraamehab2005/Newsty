import 'dart:math';
import 'package:flutter/material.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/extentions/date_time_extenion.dart';
import 'package:news_app/core/widgets/bookmark_button.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.model});
  final NewsArticleModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "News Details",
          style: TextStyle(
            color: const Color(0xFF141414),
            fontSize: AppSize.sp16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSize.pw16),
        child: Column(
          children: [
            SizedBox(height: AppSize.ph8),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.r4),
              child: CustomCachedNetworkImage(
                imagePath: model.urlToImage ?? "",
                height: AppSize.h230,
                width: double.infinity,
              ),
            ),
            SizedBox(height: AppSize.h12),
            Text(
              model.title ?? "",
              style: TextStyle(
                color: const Color(0xFF141414),
                fontSize: AppSize.sp20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: AppSize.h8),
            Row(
              children: [
                CircleAvatar(
                  radius: AppSize.r16,
                  backgroundImage: NetworkImage(model.urlToImage ?? ""),
                ),
                SizedBox(width: AppSize.pw16),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        (model.author ?? "").substring(
                          0,
                          min((model.author ?? "").length, 10),
                        ),
                        style: TextStyle(
                          fontSize: AppSize.sp14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF141414),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: AppSize.pw16),
                      Expanded(
                        child: Text(
                          model.publishedAt.formatDateTime(),
                          style: TextStyle(
                            fontSize: AppSize.sp14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF141414),
                          ),
                        ),
                      ),
                      BookmarkButton(article: model, size: 24),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSize.ph16),
            Text(
              model.description ?? "",
              style: TextStyle(
                color: const Color(0xFF363636),
                fontSize: AppSize.sp16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
