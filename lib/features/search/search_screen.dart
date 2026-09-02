import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/details/news_details_screen.dart';
import 'package:news_app/features/search/cubit/search_cubit.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return SearchCubit(NewsRepository(ApiService()));
      },
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Search")),
        body: Padding(
          padding: EdgeInsets.all(AppSize.pw16),
          child: BlocBuilder<SearchCubit , SearchState>(
            builder:
                (BuildContext context, state) {
                  return Column(
                    children: [
                      TextField(
                        controller: context.read<SearchCubit>().searchController,
                        onChanged: (value) {
                          context.read<SearchCubit>().getEveryThing();
                        },
                        decoration: InputDecoration(
                          hintText: "Search",
                          suffixIcon: Icon(
                            Icons.search,
                            color: const Color(0xFFA0A0A0),
                            size: AppSize.r30,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: state.newsEveryThingList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final model = state.newsEveryThingList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
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
                                leading: Icon(
                                  Icons.search,
                                  color: const Color(0xFFA0A0A0),
                                  size: AppSize.r20,
                                ),
                                title: Text(model.title ?? "", maxLines: 1),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(color: Color(0xFFA0A0A0));
                          },
                        ),
                      ),
                    ],
                  );
                },
          ),
        ),
      ),
    );
  }
}
