import 'package:messenger_app_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:messenger_app_flutter/shared/components/components.dart';
import 'package:messenger_app_flutter/shared/network/local/cache_helper.dart';

List<Map> tasks = [];

void signOut(context) {
  CacheHelper.removeData('token').then((value) {
    if (value) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });
}

String token = '';
