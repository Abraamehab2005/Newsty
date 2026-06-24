import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 240,
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            top: 60,
            child: Column(
              children: [
                Text(
                  "NEWST",
                  style: TextStyle(
                    color: LightColors.primaryColor,
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trending News",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "View all",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                SizedBox(
                  height: 140,
                  child: Consumer<HomeController>(
                    builder:
                        (
                          BuildContext context,
                          HomeController controller,
                          Widget? child,
                        ) {
                          switch (controller.everyThingStatus) {
                            case RequestStatusEnum.loading:
                              return Center(child: CircularProgressIndicator());
                            case RequestStatusEnum.error:
                              return Center(
                                child: Text(controller.errorMessage!),
                              );

                            case RequestStatusEnum.loaded:
                              return ListView.separated(
                                padding: EdgeInsets.only(left: 16),
                                itemCount: controller.newsEveryThingList.length,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(width: 12),
                                itemBuilder: (BuildContext context, int index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Stack(
                                      children: [
                                        if (controller
                                                .newsEveryThingList[index]
                                                .urlToImage !=
                                            null)
                                          Image.network(
                                            controller
                                                .newsEveryThingList[index]
                                                .urlToImage!,
                                            width: 240,
                                            height: 140,
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
                                      ],
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
    );
  }
}
