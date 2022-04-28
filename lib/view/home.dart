import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/navBar.dart';

import '../widgets/reportForm.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: reportForm(),
    );
  }
}
