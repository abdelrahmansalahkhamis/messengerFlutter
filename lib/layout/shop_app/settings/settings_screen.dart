import 'package:flutter/material.dart';

class Settingscreen extends StatelessWidget {
  const Settingscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Settings',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
