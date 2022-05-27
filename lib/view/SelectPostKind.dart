
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/view/normalPosts.dart';
import 'package:flutter_application_1/view/posts.dart';
import 'home.dart';
import 'navBar.dart';

class SelectPost extends StatefulWidget {
  @override
  State<SelectPost> createState() => _selectpostsState();
}
class _selectpostsState extends State<SelectPost> {
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
      body:Center(
        child: Container(
            width:MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                  child: MaterialButton(
                  elevation:5.0,
                  shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          side: BorderSide(color: Colors.red,width:3)
                      ),
                  color: Colors.white,
                  onPressed: (){
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => posts()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Image.asset('assets/problem.png',width:200,height:150,),
                  ),

                ),
              ),
            SizedBox(height:20,),
            Expanded(
              child: MaterialButton(
                elevation:5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                    side: BorderSide(color: Colors.teal,width:3)
                ),
                color: Colors.white,
              onPressed: (){
            Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => normalposts()));
            },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Image.asset('assets/lostfound.png',width:200,height:150,),
                    ),

            ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}