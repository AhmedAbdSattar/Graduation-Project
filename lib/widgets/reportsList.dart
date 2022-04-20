import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/deleteReportClass.dart';
import 'package:flutter_application_1/view/matchesReports.dart';
import 'package:flutter_application_1/widgets/reportsMatchesInfo.dart';



class reportLists {
  User? user = FirebaseAuth.instance.currentUser;

  Widget reportList(BuildContext context,String reportId, String reportKind, String item_type,
      String item_brand, String location, String date, String mColor,bool Status) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height / 4;
    final double categoryWidth = size.width / 2;

    Color niceColor=Color(0xff0000);
    switch(mColor){
      case 'Color(0xff000000)':
        niceColor =Color(0xff000000);
        break ;
      case 'Color(0xffffffff)':
        niceColor =Color(0xffffffff);
        break ;
      case 'Color(0xfff44336)':
        niceColor =Color(0xfff44336);
        break ;
      case 'Color(0xff4caf50)':
        niceColor =Color(0xff4caf50);
        break ;
      case 'Color(0xff9e9e9e)':
        niceColor =Color(0xff9e9e9e);
        break ;
      case 'Color(0xff0d47a1)':
        niceColor =Color(0xff0d47a1);
        break ;
      case 'Color(0xff3e2723)':
        niceColor =Color(0xFF3E2723);
        break ;
      case 'Color(0xff00bcd4)':
        niceColor =Color(0xff00bcd4);
        break ;
      case 'Color(0xffffeb3b)':
        niceColor =Color(0xffffeb3b);
        break ;
      case 'Color(0xffff9800)':
        niceColor =Color(0xffff9800);
        break ;
      case 'Color(0xff9c27b0)':
        niceColor =Color(0xff9c27b0);
        break ;
      case 'Color(0xffe91e63)':
        niceColor =Color(0xffe91e63);
        break ;
      case 'Color(0xffcddc39)':
        niceColor =Color(0xffcddc39);

    }
showInfo showinfo = showInfo();
var view ;
    return Container(
     // height: Status== false?190:200,
     // width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  child: Image.asset(
                      reportKind == 'lost' ? 'lost.png' : 'found.png'),
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: size.width/2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            item_type,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                          SizedBox(height: 5),
                          Text(
                            item_brand,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                          SizedBox(height: 5),
                          Text(
                            location,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            date,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                                fontSize: 10, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color:niceColor ,
                                boxShadow: [
                                  BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 1.0),
                                ]),
                            height: 20,
                            width: size.width / 2,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height:20,
            ),
            Visibility(
              visible: Status==false?false:true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon:Icon(Icons.remove_red_eye,color: Colors.black38,),
                    autofocus: false,
                    onPressed: () async {
                     await showinfo.displayInfo(context,reportId,reportKind);
                    },
                  ),
                   IconButton(
                    icon:Icon(Icons.delete,color: Colors.black38,),
                    autofocus: false,
                    onPressed: () {
                        deleteReport(context,reportId,reportKind);
                    },
                  ),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
 deleteReport( BuildContext context , String reportid , String reportType){
   showDialog(context: context, builder: (BuildContext context) {
    return AlertDialog(
      content:Container(
        width: 150,
        height: 150,
        alignment: Alignment.center,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Are you want to delete this report?' , style:TextStyle( fontSize: 15, color: Colors.black38),),
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 0,
                  child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      onPressed: () {
                        deleteReportClass.deleteReport(context,reportid,reportType);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "yes",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )),
                ),
                SizedBox(width: 30),
                Material(
                  elevation: 0,
                  child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )),
                ),
              ],
            )

          ],
        ),
      ),
    );
   });
}

}
