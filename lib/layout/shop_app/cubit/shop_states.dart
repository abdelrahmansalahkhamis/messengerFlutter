import 'package:messenger_app_flutter/models/shop_app/change_favourates_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavouratesState extends ShopStates {}

class ShopSuccessChangeFavouratesState extends ShopStates {
  final ChangeFavouratesModel model;
  ShopSuccessChangeFavouratesState(this.model);
}

class ShopErrorFavouratesState extends ShopStates {}

class ShopLoadingGetFavouratesState extends ShopStates {}

class ShopSuccessGetFavouratesState extends ShopStates {}

class ShopErrorGetFavouratesState extends ShopStates {}
