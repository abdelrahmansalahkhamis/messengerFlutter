import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_app_flutter/layout/shop_app/cubit/shop_cubit.dart';
import 'package:messenger_app_flutter/layout/shop_app/cubit/shop_states.dart';
import 'package:messenger_app_flutter/models/shop_app/favourates_model.dart';
import 'package:messenger_app_flutter/shared/styles/colors.dart';

class FavouratesScreen extends StatelessWidget {
  const FavouratesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is! ShopLoadingGetFavouratesState) {
          return ListView.separated(
            itemBuilder: (context, index) => buildFavItem(
                ShopCubit.get(context).favouratesModel!.data.data[index],
                context),
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsetsDirectional.only(start: 20.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            itemCount: ShopCubit.get(context).favouratesModel!.data.data.length,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildFavItem(FavouratesData model, context) => Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.product.image),
                    width: 120.0,
                    height: 120.0,
                    fit: BoxFit.cover,
                  ),
                  if (model.product.discount != 0)
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
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.product.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, height: 1.3),
                    ),
                    Spacer(),
                    Row(children: [
                      Text(
                        model.product.price.toString(),
                        style: TextStyle(
                            fontSize: 12.0, height: 1.3, color: defaultColor),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (1 != 0)
                        Text(model.product.oldPrice.toString(),
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
                                .changeFavourates(model.product.id);
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor:
                                //ShopCubit.get(context).favourates![productModel.id]
                                ShopCubit.get(context)
                                        .favourates[model.product.id]!
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
        ),
      );
}
