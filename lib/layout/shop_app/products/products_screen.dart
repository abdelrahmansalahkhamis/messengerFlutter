import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_app_flutter/layout/shop_app/cubit/shop_cubit.dart';
import 'package:messenger_app_flutter/layout/shop_app/cubit/shop_states.dart';
import 'package:messenger_app_flutter/models/shop_app/categories_model.dart';
import 'package:messenger_app_flutter/models/shop_app/home_model.dart';
import 'package:messenger_app_flutter/shared/components/components.dart';
import 'package:messenger_app_flutter/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is ShopSuccessChangeFavouratesState) {
          if (!state.model.status) {
            showToast('${state.model.status}', ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        if (ShopCubit.get(context).homeModel != null &&
            ShopCubit.get(context).categoriesModel != null) {
          return builderWidget(ShopCubit.get(context).homeModel!,
              ShopCubit.get(context).categoriesModel!, context);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget builderWidget(
      HomeModel model, CategoriesModel categoriesModel, context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${model.data.banners[0].image}'),
                      //image: NetworkImage(
                      //'https://student.valuxapps.com/storage/uploads/categories/16301438353uCFh.29118.jpg'),
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
                  scrollDirection: Axis.horizontal)),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        buildCategoryItem(categoriesModel.data.data[index]),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 20.0,
                    ),
                    itemCount: categoriesModel.data.data.length,
                  ),
                ),
                Text(
                  'New Products',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.red,
            child: Flexible(
              child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                  childAspectRatio: 1 / 1.50,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(
                      model.data.products.length,
                      (index) => buildGridProduct(
                          model.data.products[index], context))),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCategoryItem(CategoriesDataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: 100.0,
            child: Text(
              model.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
            ),
          )
        ],
      );

  Widget buildGridProduct(Product productModel, context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(productModel.image),
                width: double.infinity,
                //fit: BoxFit.cover,
              ),
              if (productModel.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 8.0, color: Colors.white),
                  ),
                )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productModel.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, height: 1.3),
                ),
                Row(children: [
                  Text(
                    '${productModel.price.round()}',
                    style: TextStyle(
                        fontSize: 12.0, height: 1.3, color: defaultColor),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if (productModel.discount != 0)
                    Text('${productModel.oldPrice.round()}',
                        style: TextStyle(
                            fontSize: 10.0,
                            height: 1.3,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough)),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        //ShopCubit.get(context).favourates[productModel.id];
                        ShopCubit.get(context)
                            .changeFavourates(productModel.id);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:
                            //ShopCubit.get(context).favourates![productModel.id]
                            ShopCubit.get(context).favourates[productModel.id]!
                                ? defaultColor
                                : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ))
                ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
