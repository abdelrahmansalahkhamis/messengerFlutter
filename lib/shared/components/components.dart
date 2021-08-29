import 'package:flutter/material.dart';
import 'package:messenger_app_flutter/shared/cubit/cubit.dart';

// Widget defaultButton(
//         @required bool isUpperCased,
//         @required double width,
//         @required Color background,
//         @required VoidCallback function,
//         @required String text,
//         @required double raduis) =>
//     Container(
//       color: background,
//       width: width,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(raduis),
//       ),
//       child: MaterialButton(
//         onPressed: function,
//         child: Text(
//           text.toUpperCase(),
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );

Widget defaultButton(
        Color background, VoidCallback function, String text, double raduis,
        {bool isUpperCased = true, double width = double.infinity}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCased ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

var passwordVisible = false;

Widget defaultTextFormField(
        @required TextEditingController controller,
        @required String label,
        @required IconData prefix,
        @required IconData? suffix,
        @required bool isPassword,
        @required TextInputType type,
        @required bool isClickable,
        @required String? Function(String? value) validate,
        @required Function onSubmit,
        @required Function onChange,
        @required Function onTap,
        @required VoidCallback suffixPressed) =>
    TextFormField(
      controller: controller,
      validator: validate,
      onChanged: onChange(),
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit(),
      onTap: onTap(),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(icon: Icon(suffix), onPressed: suffixPressed)
            : null,
        // suffixIcon: suffix != null
        //     ? GestureDetector(
        //         child: passwordVisible
        //             ? Icon(Icons.visibility_off)
        //             : Icon(Icons.visibility),
        //         onTap: () {
        //           setState() {
        //             passwordVisible = !passwordVisible;
        //           }

        //           print('pressed');
        //         },
        //       )
        //     : null,
        border: OutlineInputBorder(),
      ),
    );

Widget buildTaskItem(Map model, context) {
  return Dismissible(
    key: Key(model['id'].toString()),
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40.0,
            child: Text('${model['title']}'),
            backgroundColor: Colors.blue,
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model['time']}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  '${model['date']}',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          IconButton(
              onPressed: () {
                AppCubit.get(context).updateData('done', model['id']);
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              )),
          IconButton(
              onPressed: () {
                AppCubit.get(context).updateData('archived', model['id']);
              },
              icon: Icon(
                Icons.archive,
                color: Colors.black45,
              )),
        ],
      ),
    ),
    onDismissed: (direction) {
      AppCubit.get(context).deleteData(model['id']);
    },
  );
}


//Widget tasksBuilder(List<Map> tasks) => 
