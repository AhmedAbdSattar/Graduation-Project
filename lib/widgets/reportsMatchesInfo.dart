import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/matchesReports.dart';
import 'package:flutter_application_1/widgets/reportsList.dart';

class showInfo {
  displayInfo(BuildContext context, String reportid ,String reportkind) async{
     String collection = 'lostReports';
     if (reportkind == 'found') collection = 'foundReports';

     final _fireStore = FirebaseFirestore.instance;

         var matches =[];
       // Get docs from collection reference
       QuerySnapshot querySnapshot = await _fireStore.collection(collection).where('reportId',isEqualTo: reportid).get();

       // Get data from docs and convert map to List
       final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
       //for a specific field
      final aData = querySnapshot.docs.map((doc) => doc.get(collection=='lostReports'?'matchesLids':'matchesFids')).
      forEach((element) {
         if (element is String) {
           matches.add(element);
         }
         else{
           matches = element;
         }
      });
      List<Widget> all =[] ;
      for (var item in matches){
         all.add(await Display(context,item)) ;
      }
      showUserInfo(all, context);
   }
    Display(BuildContext context,String userid)async {
var widget ;
 QuerySnapshot stream = await FirebaseFirestore.instance.collection('users').
     where('uid',isEqualTo: userid).get();
      stream.docs.forEach((element) {
      widget =newWidget( element.get('firstName'), element.get('email'), element.get('phone'),context);
     });
      return(widget);
   }

   showUserInfo(List<Widget> widgets ,BuildContext context)
   {
     showDialog(useSafeArea: true,
         context: context, builder: (BuildContext context)
     {
       return AlertDialog(
         content: Container(
           padding: EdgeInsets.all(20),
           width: MediaQuery
               .of(context)
               .size
               .width,
           height: MediaQuery
               .of(context)
               .size
               .height,
           child: Column(
             //mainAxisAlignment: MainAxisAlignment.center,
             //crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Text('All user information for similar reports',
                 style: TextStyle(fontSize: 15, color: Colors.black87),),
               SizedBox(height: 20),
                lists(widgets, context),
               SizedBox(height: 20),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Material(
                     elevation: 0,
                     borderRadius: BorderRadius.circular(30),
                     color: Colors.white12,
                     child: MaterialButton(
                         padding: EdgeInsets.fromLTRB(20, 15, 20, 5),
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
   Widget newWidget ( String FirstName,
       String Email,String phone ,BuildContext context){
       return Container(
       //  width:MediaQuery.of(context).size.width*0.6,
       //  height:MediaQuery.of(context).size.height*.6,
         padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
         child: Column(
           //crossAxisAlignment: CrossAxisAlignment.center,
           //mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text(FirstName , style:TextStyle( fontSize: 20, color: Colors.teal), ),
             SizedBox(height: 10),

                 Text('$Email' , style:TextStyle( fontSize: 15, color: Colors.black), ),
                 SizedBox(height: 3),
                 Text('Phone: $phone' , style:TextStyle( fontSize: 15, color: Colors.black), ),
                  SizedBox(height: 3),
                 Container( color: Colors.black38, height: 5, width: 100,),

           ],
         )
     );
   }
Widget lists(List <Widget> lists,BuildContext context){
    return Container(
        width:MediaQuery.of(context).size.width*0.6,
        height:MediaQuery.of(context).size.height*0.6,
        child: ListView(children:lists));
}
  }


