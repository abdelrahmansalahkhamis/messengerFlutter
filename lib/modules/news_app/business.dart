import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_app_flutter/layout/cubit/cubit.dart';
import 'package:messenger_app_flutter/layout/cubit/states.dart';
import 'package:messenger_app_flutter/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var list = NewsCubit.get(context).business;
        return state is! NewsGetBusinessLoadingState
            ? ListView.separated(
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
                itemCount: 10)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
