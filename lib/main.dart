import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:messenger_app_flutter/layout/cubit/cubit.dart';
import 'package:messenger_app_flutter/layout/shop_app/shop_layout.dart';
import 'package:messenger_app_flutter/layout/todo_app/news_app/news_layout.dart';
import 'package:messenger_app_flutter/messenger_screen.dart';
import 'package:messenger_app_flutter/modules/basics_app/login/login_screen.dart';
import 'package:messenger_app_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:messenger_app_flutter/shared/cubit/cubit.dart';
import 'package:messenger_app_flutter/shared/cubit/states.dart';
import 'package:messenger_app_flutter/shared/network/local/cache_helper.dart';
import 'package:messenger_app_flutter/shared/network/remote/dio_helper.dart';
import 'package:messenger_app_flutter/shared/styles/themes.dart';
import 'package:messenger_app_flutter/users.dart';

import 'bmi_screen.dart';
import 'layout/todo_app/todo_layout.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'shared/bloc_observer.dart';

void main() async {
  //بيأكد ان كل حاجة هنا في الميثود خلصت وبعدين يرن الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? isDark = CacheHelper.getData('isDark');
  bool? onBoarding = CacheHelper.getData('onBoarding');
  String? token = CacheHelper.getData('token');
  if (onBoarding != null) {
    print('on boarding not null :- $onBoarding');
    if (token != null) {
      print('token not null :- $token');
      widget = ShopLayout();
    } else {
      print('token is null :- $token');
      widget = ShopLoginScreen();
    }
  } else {
    print('on boarding is null :- $onBoarding');
    widget = OnBoardingScreen();
  }
  //runApp(MyApp(isDark!, onBoarding!));
  runApp(MyApp(isDark!, widget));
}

class MyApp extends StatelessWidget {
  bool isDark;
  Widget onBoarding;

  // MyApp(this.isDark, this.onBoarding);
  MyApp(this.isDark, this.onBoarding);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => NewsCubit()..getBusiness()),
        BlocProvider(create: (context) => AppCubit()..changeAppMode(isDark))
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: lightTheme,
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              darkTheme: darkTheme,
              home: Directionality(
                  textDirection: TextDirection.ltr,
                  //child: onBoarding ? ShopLoginScreen() : OnBoardingScreen()),
                  child: onBoarding));
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
