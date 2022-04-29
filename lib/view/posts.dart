

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
List<String> govern = [
  'all',
  'Cairo',
  'Giza',
  'Alexandria',
  'Dakahlia',
  'Red Sea',
  'Beheira',
  'Fayoum',
  'Gharbiya',
  'Ismailia',
  'Menofia',
  'Minya',
  'Qaliubiya',
  'New Valley',
  'Suez',
  'Aswan',
  'Assiut',
  'Beni Suef',
  'Port Said',
  'Damietta',
  'Sharkia',
  'South Sinai',
  'Kafr Al sheikh',
  'Matrouh',
  'Luxor',
  'Qena',
  'North Sinai',
  'Sohag'
];
class _postsState extends State<posts> {
  String selectedGov='all';
  String filter ='postTime';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Filter by time',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_emotions_rounded),
            label: 'Filter by reactions',
            backgroundColor: Colors.white,
          ),
        ],

        onTap: (int index) {
          setState(() {
            if (index == 0) {
              filter = 'postTime';
            }
            else {
              filter = 'likes';
            }
          });
        },
        currentIndex: filter == 'postTime' ? 0 : 1,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.black38,
      ),
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
      body:Container(
        height: MediaQuery.of(context).size.height*0.8,
        child: SingleChildScrollView(
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
                        hint: Text('Location filter '),
                        value: selectedGovernorate,
                        validator:(value) {
                          if(value == null){
                            return ('City required!');
                          }
                        } ,
                        isExpanded: false,
                        items: govern.map((String value) {
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
      ),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>showFormDialog(context),
        child: Icon(Icons.post_add),
      ),
    );
  }
}
Widget getData(BuildContext context,String locationFilter,String filter) {
print(filter);

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
  if(locationFilter == 'all'){
    filtered = false;
  }
  snapshot.data?.docs.forEach((element) {
    if(filtered?element['locationTown']==locationFilter:element['locationTown'] !=null){
      posts.add(showPost(context,element['postOwnerId'] ,element['postId'], element['postOwner'], element['postDescription'], element['imageUrl'], element['location'],element['postTime'], element['likes'], element['comments']));
    }
  });
  if(posts.isEmpty){
    posts.add(Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text('No posts in ${locationFilter == 'all'?'timeline':locationFilter} yet',style: TextStyle(fontSize:25,color: Colors.black38),),
    )
    );
  }
  return posts;
}
