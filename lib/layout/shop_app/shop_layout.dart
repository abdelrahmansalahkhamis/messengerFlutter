import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_app_flutter/layout/shop_app/cubit/shop_cubit.dart';
import 'package:messenger_app_flutter/layout/shop_app/cubit/shop_states.dart';
import 'package:messenger_app_flutter/modules/news_app/search/search_screen.dart';
import 'package:messenger_app_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:messenger_app_flutter/shared/components/components.dart';
import 'package:messenger_app_flutter/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(
                onPressed: () {
                  //navigateTo(context, SearchScreen());
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomitems,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }
}
