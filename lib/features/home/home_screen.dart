import 'dart:math';
import 'package:flutter/material.dart';
import 'package:news_app/features/home/components/categories_list.dart';
import 'package:news_app/features/home/components/trending_news.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context) => HomeController(),
      child: Consumer<HomeController>(
        builder:
            (BuildContext context, HomeController controller, Widget? child) {
              return Scaffold(
                body: CustomScrollView(
                  slivers: [
                    TrendingNews(),
                    SliverToBoxAdapter(
                      child: ViewAllComponent(
                        title: "Categories",
                        titleColor: Color(0xFF141414),
                        onTap: () {},
                      ),
                    ),
                    CategoriesList(),
                    SliverList.builder(
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
                              model.urlToImage != null &&
                                      model.urlToImage!.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        model.urlToImage ?? "",
                                        height: 80,
                                        width: 180,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Container(
                                                height: 70,
                                                width: 120,
                                                color: Colors.grey[300],
                                                child: const Icon(
                                                  Icons.broken_image,
                                                  color: Colors.grey,
                                                ),
                                              );
                                            },
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return const SizedBox(
                                                height: 70,
                                                width: 120,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                      ),
                                                ),
                                              );
                                            },
                                      ),
                                    )
                                  : Container(
                                      height: 70,
                                      width: 120,
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey,
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
                                                formatDateTime(
                                                  model.publishedAt ?? "",
                                                ),
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
                  ],
                ),
              );
            },
      ),
    );
  }

  // TODO : Refactor
  String formatDateTime(String? date) {
    if (date == null) return "";
    final diff = DateTime.now().difference(DateTime.parse(date));
    if (diff.inMinutes < 60) {
      return "${diff.inMinutes}m ago";
    }
    if (diff.inHours < 24) {
      return "${diff.inHours}h ago";
    }
    return "${diff.inDays}d ago";
  }
}
