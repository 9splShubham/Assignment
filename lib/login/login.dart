import 'package:assignment/add_to_cart/add_to_cart.dart';
import 'package:assignment/core/app_string.dart';
import 'package:assignment/db_helper.dart';
import 'package:assignment/main.dart';
import 'package:assignment/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.textPractice),
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Align(alignment: Alignment.center, child: Text(AppString.textLOGIN)),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: userNameController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.grey,
                    filled: true,
                    hintText: AppString.textName),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: passwordcontroller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.grey,
                    filled: true,
                    hintText: AppString.textNametextEnterPassword),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyApp()));
                      },
                      child: Text(AppString.textLOGIN)))
            ],
          ),
        ),
      ),
    );
  }
}
