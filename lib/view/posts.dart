import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/postForm.dart';

import '../widgets/postWidget.dart';
import 'home.dart';
import 'navBar.dart';

class posts extends StatefulWidget {
  @override
  State<posts> createState() => _postsState();
}

class _postsState extends State<posts> {
  String selectedGov='undefined';
  String filter ='likes';
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
      body:SingleChildScrollView(
        child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding:EdgeInsets.fromLTRB(5, 10, 5, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width:MediaQuery.of(context).size.width/2,
                  child: DropdownButtonFormField<String>(
                    dropdownColor: Colors.white,
                    hint: Text('Location '),
                    value: selectedGovernorate,
                    validator:(value) {
                      if(value == null){
                        return ('City required!');
                      }
                    } ,
                    isExpanded: false,
                    items: gov.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (gov) {
                      if(gov!.isEmpty){
                        return ;
                      }
                      setState(() {
                        selectedGov = gov;
                      });
                    },

                  ),
                ),],
            ),
          ),
          Container(
            child: getData(context,selectedGov,filter),
          ),
        ],
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>showFormDialog(context),
        child: Icon(Icons.post_add),
      ),
    );
  }
}
Widget getData(BuildContext context,String locationFilter,String filter) {


  var stream = FirebaseFirestore.instance.collection('posts').orderBy(filter,descending:true).snapshots();

  return StreamBuilder<QuerySnapshot>(
    stream: stream,
    builder: (BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return new Center(child: new CircularProgressIndicator());
        default:
          return new Column(children: getExpenseItems(snapshot, context,locationFilter));
      }
    },
  );
}
List <Widget> getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context,String locationFilter) {
  List <Widget> posts =[];
  bool filtered = true;
  if(locationFilter == 'undefined'){
    filtered = false;
  }
  snapshot.data?.docs.forEach((element) {
    if(filtered?element['locationTown']==locationFilter:element['locationTown'] !=null){
      posts.add(showPost(context, element['postId'], element['postOwner'], element['postDescription'], element['imageUrl'], element['location'],element['postTime'], element['likes'], element['comments']));
    }
  });
  if(posts.isEmpty){
    posts.add(Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text('No posts in $locationFilter yet',style: TextStyle(fontSize:25,color: Colors.black38),),
    )
    );
  }
  return posts;
}
