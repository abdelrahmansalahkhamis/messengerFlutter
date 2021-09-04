import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_app_flutter/layout/cubit/cubit.dart';
import 'package:messenger_app_flutter/layout/cubit/states.dart';
import 'package:messenger_app_flutter/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: defaultTextFormField(
                    searchController,
                    'search',
                    Icons.search,
                    Icons.search,
                    false,
                    TextInputType.text,
                    true,
                    (value) {
                      if (value!.isEmpty) {
                        return 'search must not be empty';
                      }
                      return null;
                    },
                    () {},
                    // (value) {
                    //   NewsCubit.get(context).getSearch(value);
                    // },
                    (value) {
                      NewsCubit.get(context).getSearch(value!);
                    },
                    () {},
                    () {}),
              ),
              //Expanded(child: buildArticleItems(list[index], context))
              Expanded(
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildArticleItems(list[index], context),
                      separatorBuilder: (context, index) => Padding(
                            padding: EdgeInsetsDirectional.only(start: 20.0),
                            child: Container(
                              width: double.infinity,
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                          ),
                      itemCount: list.length))
            ],
          ),
        );
      },
    );
  }
}
