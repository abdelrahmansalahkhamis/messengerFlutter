import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_app_flutter/layout/shop_app/categories/categories_screen.dart';
import 'package:messenger_app_flutter/layout/shop_app/cubit/shop_states.dart';
import 'package:messenger_app_flutter/layout/shop_app/favourates/favourates_screen.dart';
import 'package:messenger_app_flutter/layout/shop_app/products/products_screen.dart';
import 'package:messenger_app_flutter/layout/shop_app/settings/settings_screen.dart';
import 'package:messenger_app_flutter/models/shop_app/home_model.dart';
import 'package:messenger_app_flutter/shared/components/constants.dart';
import 'package:messenger_app_flutter/shared/network/end_points/end_points.dart';
import 'package:messenger_app_flutter/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouratesScreen(),
    Settingscreen()
  ];

  void changeIndex(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  List<BottomNavigationBarItem> bottomitems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favourates'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
  ];

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      printFullText(homeModel.toString());
      print(homeModel.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print('error.toString() is ${error.toString()}');
      emit(ShopErrorHomeDataState());
    });
  }
}
