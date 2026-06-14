import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
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
                body: (controller.errorMessage?.isNotEmpty ?? false)
                    ? Center(child: Text(controller.errorMessage!))
                    : controller.everyThingLoading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.newsTopHeadLineList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Text(
                                  controller.newsTopHeadLineList[index].title ??
                                      "",
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              );
            },
      ),
    );
  }
}
