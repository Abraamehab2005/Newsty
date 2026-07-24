import 'package:flutter/material.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/extentions/date_time_extenion.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/details/news_details_screen.dart';
import 'package:news_app/features/home/components/trending_news_shimmer.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: AppSize.h330,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: AppSize.h240,
              child: Image.asset("assets/images/background.png", fit: BoxFit.cover),
            ),
            Positioned.fill(
              top: AppSize.ph60,
              child: Column(
                children: [
                  Text(
                    "NEWST",
                    style: TextStyle(
                      color: LightColors.primaryColor,
                      fontSize: AppSize.sp40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: AppSize.ph6),
                  ViewAllComponent(title: "Trending News", onTap: () {}),
                  SizedBox(height: AppSize.ph12),
                  SizedBox(
                    height: AppSize.h140,
                    child: Consumer<HomeController>(
                      builder:
                          (
                            BuildContext context,
                            HomeController controller,
                            Widget? child,
                          ) {
                            switch (controller.everyThingStatus) {
                              case RequestStatusEnum.loading:
                                return TrendingNewsShimmer();
                              case RequestStatusEnum.error:
                                return Center(child: Text(controller.errorMessage!));

                              case RequestStatusEnum.loaded:
                                return ListView.separated(
                                  padding: EdgeInsets.only(left: AppSize.pw16),
                                  itemCount: controller.newsEveryThingList.take(6).length,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (BuildContext context, int index) =>
                                      SizedBox(width: AppSize.pw12),
                                  itemBuilder: (BuildContext context, int index) {
                                    final model = controller.newsEveryThingList[index];
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
                                      child: SizedBox(
                                        width: AppSize.pw240,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(AppSize.r8),
                                          child: Stack(
                                            children: [
                                              if (model.urlToImage != null)
                                                CustomCachedNetworkImage(
                                                  imagePath: model.urlToImage ?? "",
                                                  height: AppSize.h140,
                                                  width: AppSize.w240,
                                                ),
                                              Positioned.fill(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                      colors: [
                                                        Colors.black.withValues(
                                                          alpha: 0.5,
                                                        ),
                                                        Colors.black.withValues(
                                                          alpha: 0.7,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: AppSize.ph12,
                                                left: AppSize.pw12,
                                                right: AppSize.pw12,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      maxLines: 2,
                                                      model.title.toString(),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Color(0xFFFFFCFC),
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                    SizedBox(height: AppSize.ph6),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                      model.urlToImage
                                                                          .toString(),
                                                                    ),
                                                                radius: AppSize.r10,
                                                              ),
                                                              SizedBox(
                                                                width: AppSize.pw6,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  maxLines: 1,
                                                                  model.author ?? "",
                                                                  style: TextStyle(
                                                                    color: Color(
                                                                      0xFFFFFCFC,
                                                                    ),
                                                                    fontSize:
                                                                        AppSize.sp12,
                                                                    fontWeight:
                                                                        FontWeight.w400,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                          model.publishedAt
                                                              .formatDateTime(),
                                                          style: TextStyle(
                                                            color: Color(0xFFFFFCFC),
                                                            fontSize: AppSize.sp14,
                                                            fontWeight: FontWeight.w400,
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
                                      ),
                                    );
                                  },
                                );
                            }
                          },
                    ),
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
