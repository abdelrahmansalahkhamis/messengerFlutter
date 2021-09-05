import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_app_flutter/models/shop_app/login_model.dart';
import 'package:messenger_app_flutter/modules/basics_app/login/login_screen.dart';
import 'package:messenger_app_flutter/modules/shop_app/login/cubit/states.dart';
import 'package:messenger_app_flutter/shared/network/end_points/end_points.dart';
import 'package:messenger_app_flutter/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin(@required String email, @required String password) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      print('login operation is : $value');
      print('value.data is ${value.data}');
      print('loginModel 1 is is is $loginModel');
      loginModel = ShopLoginModel.fromJson(value.data);
      print('loginModel 2 is is is $loginModel');
      print(loginModel!.status);
      print('-----------');
      print(loginModel!.message);
      print('-----------');
      print(loginModel!.data);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;

  bool isPassword = true;

  void changePasswordVisibility() {
    //suffix = Icons.visibility_off_outlined;
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopChangePasswordVisibilityState());
  }
}
