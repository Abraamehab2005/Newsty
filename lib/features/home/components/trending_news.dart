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
                                  final model =
                                      controller.newsEveryThingList[index];
                                  return SizedBox(
                                    width: 240,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Stack(
                                        children: [
                                          if (model.urlToImage != null)
                                            Image.network(
                                              model.urlToImage!,
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
                                          Positioned(
                                            bottom: 12,
                                            left: 12,
                                            right: 12,
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
                                                SizedBox(height: 6),
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                            model.urlToImage
                                                                .toString(),
                                                          ),
                                                      radius: 10,
                                                    ),
                                                    SizedBox(width: 6),
                                                    Text(
                                                      model.author.toString(),
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xFFFFFCFC,
                                                        ),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ), // remeber this if eny error occure
                                          ),
                                        ],
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
    );
  }
}
