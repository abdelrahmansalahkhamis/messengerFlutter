import 'package:flutter/material.dart';
import 'package:messenger_app_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:messenger_app_flutter/shared/components/components.dart';
import 'package:messenger_app_flutter/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salla'),
      ),
      body: TextButton(
        child: Text('SIGN OUT'),
        onPressed: () {
          CacheHelper.removeData('token').then((value) {
            if (value) {
              navigateAndFinish(context, ShopLoginScreen());
            }
          });
        },
      ),
    );
  }
}
