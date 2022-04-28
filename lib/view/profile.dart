import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/editProfileForm.dart';

import 'home.dart';
import 'navBar.dart';

class profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navBar(),
      appBar: AppBar(
        title: SizedBox(
            height: 100,
            width: 150,
            child: Image.asset(
              "assets/logo2.png",
              fit: BoxFit.contain,
            )),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          )
        ],
        centerTitle: true,
      ),
      body: editProfileForm(),
    );
  }
}
