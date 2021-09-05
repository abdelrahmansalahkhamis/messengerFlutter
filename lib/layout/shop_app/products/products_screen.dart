import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_app_flutter/layout/shop_app/cubit/shop_cubit.dart';
import 'package:messenger_app_flutter/layout/shop_app/cubit/shop_states.dart';
import 'package:messenger_app_flutter/models/shop_app/home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (ShopCubit.get(context).homeModel != null) {
          return productsBuilder(ShopCubit.get(context).homeModel!);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
    // if (ShopCubit.get(context).homeModel != null) {
    //   return productsBuilder(ShopCubit.get(context).homeModel!);
    // } else {
    //   return Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }
  }

  Widget productsBuilder(HomeModel model) {
    return Column(
      children: [
        CarouselSlider(
            items: model.data.banners
                .map(
                  (e) => Image(
                    image: NetworkImage(''),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                viewportFraction: 1.0,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 1),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                scrollDirection: Axis.horizontal))
      ],
    );
  }
}
