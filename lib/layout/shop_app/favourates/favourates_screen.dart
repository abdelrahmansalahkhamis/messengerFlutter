import 'package:flutter/material.dart';

class FavouratesScreen extends StatelessWidget {
  const FavouratesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Favourates',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
