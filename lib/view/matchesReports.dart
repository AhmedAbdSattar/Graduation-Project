import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/deleteReportClass.dart';
import 'package:flutter_application_1/widgets/reportForm.dart';
import 'package:rxdart/rxdart.dart';

import '../widgets/reportsList.dart';
import 'home.dart';
import 'navBar.dart';

class matchedReports extends StatefulWidget {

  @override
  State<matchedReports> createState() => _myReportState();
}

class _myReportState extends State<matchedReports> {
  List <String> SelectedType = ['lost', 'found'];

  var selected = 'lost';

  reportLists buildList = reportLists();

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
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
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search_off),
              label: 'Lost',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check),
              label: 'Found',
              backgroundColor: Colors.white,
            ),
          ],

          onTap: (int index) {
            setState(() {
              if (index == 0) {
                selected = 'lost';
              }
              else {
                selected = 'found';
              }
            });

          },
          currentIndex: selected=='lost'?0:1,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.black38,
        ),
        body: getData(context, selected),


    );
  }

  Widget getData(BuildContext context, String reportType) {
    String collection = 'lostReports';
    if (reportType == 'found') collection = 'foundReports';

    var stream = FirebaseFirestore.instance.collection(collection).where(
        'status', isEqualTo: true).snapshots();
    
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          default:
            return new ListView(children: getExpenseItems(snapshot, context));
        }
      },
    );
  }
reportLists bulidLists = reportLists();
  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
    List<Widget> reports = [];
      snapshot.data?.docs.forEach((element) {
        if (element['userid'] == user!.uid) {
            reports.add(Container(
              child: bulidLists.reportList(context,element['reportId'], element['Reportkind'], element['itemtype'],
                  element['itembrand'],element['location']
                  , element['date'], element['itemcolor'] , element['status']),
            ));
        }
      });

    if( reports.isEmpty){
      reports.add(
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(50),
            child: Text('No Reports Avaiable yet! ',
              style: TextStyle(fontSize: 20, color: Colors.black38),),));
    }
    return reports;
  }

}


