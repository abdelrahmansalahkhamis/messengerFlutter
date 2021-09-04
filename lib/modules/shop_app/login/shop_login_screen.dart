import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:messenger_app_flutter/layout/shop_app/shop_layout.dart';
import 'package:messenger_app_flutter/modules/shop_app/login/cubit/cubit.dart';
import 'package:messenger_app_flutter/modules/shop_app/login/cubit/states.dart';
import 'package:messenger_app_flutter/modules/shop_app/register/shop_register_screen.dart';
import 'package:messenger_app_flutter/shared/components/components.dart';
import 'package:messenger_app_flutter/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          print('state is : $state');
          // TODO: implement listener
          if (state is ShopLoginSuccessState) {
            print('state is ShopLoginSuccessState');
            if (state.loginModel.status) {
              print('state is ShopLoginSuccessState true true');
              CacheHelper.saveData('token', state.loginModel.data.token)
                  .then((value) {
                navigateAndFinish(context, ShopLayout());
              });
            }
          } else {
            print('state.loginModel.message is ${state.loginModel.message}');
            showToast(state.loginModel.message, ToastState.ERROR);
          }
          // if (state is ShopLoginSuccessState) {
          //   if (state.loginModel.status) {
          //     print(state.loginModel.status);
          //     print(state.loginModel.data.token);
          // Fluttertoast.showToast(
          //     msg: state.loginModel.message,
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.BOTTOM,
          //     timeInSecForIosWeb: 5,
          //     backgroundColor: Colors.green,
          //     textColor: Colors.white,
          //     fontSize: 16.0);
          //   }
          // } else {
          //   Fluttertoast.showToast(
          //       msg: state.loginModel.message,
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.BOTTOM,
          //       timeInSecForIosWeb: 1,
          //       backgroundColor: Colors.red,
          //       textColor: Colors.white,
          //       fontSize: 16.0);
          // }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                        Text('LOGIN now to browse our hot efforts',
                            style: Theme.of(context).textTheme.bodyText2),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                            emailController,
                            'Email Address',
                            Icons.email_outlined,
                            null,
                            false,
                            TextInputType.emailAddress,
                            true, (value) {
                          if (value!.isEmpty) {
                            return 'email cannot be empty';
                          }
                        }, () {}, (value) {}, () {}, () {}),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                            passwordController,
                            'password',
                            Icons.lock,
                            ShopLoginCubit.get(context).suffix,
                            ShopLoginCubit.get(context).isPassword,
                            TextInputType.emailAddress,
                            true,
                            (value) {
                              if (value!.isEmpty) {
                                return 'password cannot be empty';
                              }
                            },
                            () {},
                            (value) {},
                            () {},
                            () {
                              ShopLoginCubit.get(context)
                                  .changePasswordVisibility();
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        // state is ShopLoginLoadingState() ? defaultButton(Colors.blue, () {}, 'login', 10.0) : Center(
                        //   child: CircularProgressIndicator(),
                        // ),
                        defaultButton(Colors.blue, () {
                          if (formKey.currentState!.validate()) {
                            ShopLoginCubit.get(context).userLogin(
                                emailController.text, passwordController.text);
                          }
                        }, 'login', 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Dont\'t have an account? '),
                            defaultTextButton(() {
                              navigateTo(context, ShopRegisterScreen());
                            }, 'Register')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
