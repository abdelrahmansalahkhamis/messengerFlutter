import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_app_flutter/layout/shop_app/cubit/shop_cubit.dart';
import 'package:messenger_app_flutter/layout/shop_app/cubit/shop_states.dart';
import 'package:messenger_app_flutter/models/shop_app/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        //return Container();
        if (ShopCubit.get(context).categoriesModel != null)
          // ignore: curly_braces_in_flow_control_structures
          return ListView.separated(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCatItem(
                ShopCubit.get(context).categoriesModel!.data.data[index]),
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsetsDirectional.only(start: 20.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
            cacheExtent: double.infinity,
          );
        else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }

  Widget buildCatItem(CategoriesDataModel model) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            model.name,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
