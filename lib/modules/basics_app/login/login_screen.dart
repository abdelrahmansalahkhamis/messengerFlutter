import 'package:flutter/material.dart';
import 'package:messenger_app_flutter/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Login',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  defaultTextFormField(emailController, 'email', Icons.email,
                      null, false, TextInputType.emailAddress, true, (value) {
                    if (value!.isEmpty) {
                      return 'email address must not be empty';
                    } else {
                      return null;
                    }
                  }, () {}, (value) {}, () {}, () {}),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultTextFormField(
                      passwordController,
                      'password',
                      Icons.lock,
                      Icons.visibility,
                      isPassword,
                      TextInputType.visiblePassword,
                      true,
                      (value) {
                        if (value!.isEmpty) {
                          return 'password must not be empty';
                        } else {
                          return null;
                        }
                      },
                      () {},
                      (value) {},
                      () {},
                      () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                        print('pressed');
                      }),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultButton(Colors.blue, () {
                    if (formKey.currentState!.validate()) {
                      print(emailController.text);
                      print(passwordController.text);
                    }
                  }, 'Login', 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'don\'t have account?',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        child: Text('Register New',
                            style: TextStyle(
                              color: Colors.blue,
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
