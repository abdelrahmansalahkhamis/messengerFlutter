import 'package:flutter/material.dart';

class Users extends StatelessWidget {
  //const Users({Key? key}) : super(key: key);

  List<UserModel> users = [
    UserModel(1, 'Abdullah Mansour', '012345765434'),
    UserModel(1, 'Abdullah Mansour', '012345765434'),
    UserModel(1, 'Abdullah Mansour', '012345765434'),
    UserModel(1, 'Abdullah Mansour', '012345765434'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => buildUser(),
          separatorBuilder: (context, index) => SizedBox(
                height: 10.0,
              ),
          itemCount: 15),
    );
  }

  Widget buildUser() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 60.0,
            width: 60.0,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(50.0)),
            child: Center(
              child: Text(
                '1',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25.0),
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Abdullah Mansour',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25.0),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '+201115342559',
                style: TextStyle(
                    fontWeight: FontWeight.w200,
                    color: Colors.black,
                    fontSize: 15.0),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class UserModel {
  final int index;
  final String name;
  final String phone;
  UserModel(this.index, this.name, this.phone);
}
