
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/model/foundReports.dart';
import 'package:flutter_application_1/model/lostReports.dart';

import 'Notify.dart';

class matchingAlgorithem {
  User? user = FirebaseAuth.instance.currentUser;
   Future<void> matchingFound(foundReportModel report) async {
    List<String?> ids = [];
    bool mainstatus = false;

    FirebaseFirestore.instance
        .collection('lostReports')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (
            doc["reportId"] != report.reportId &&
            doc["userid"] != user!.uid &&
            doc["itemtype"] == report.itemtype &&
            doc["itembrand"] == report.itembrand &&
            doc["serialnumber"] == report.serialnumber &&
            doc["location"] == report.location) {
          ids.add(doc["userid"]);
          sendNotification(doc["userid"],doc["itemtype"]);
          mainstatus = true;
          //update all equals
          FirebaseFirestore.instance
              .collection('lostReports')
              .doc(doc["reportId"])
              .update({'status': true, 'matchesLids': report.userid});
        }
      });
      FirebaseFirestore.instance
          .collection('foundReports')
          .doc(report.reportId)
          .update({'status': mainstatus, 'matchesFids': ids});
    });
  }

   Future<void> matchingLost(lostReportModel report) async {
    List<String?> ids = [];
    bool mainstatus = false;

    FirebaseFirestore.instance
        .collection('foundReports')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (
            doc["reportId"] != report.reportId &&
            doc["userid"] != user!.uid &&
            doc["itemtype"] == report.itemtype &&
            doc["itembrand"] == report.itembrand &&
            doc["serialnumber"] == report.serialnumber &&
            doc["location"] == report.location) {
          ids.add(doc["userid"]);
          sendNotification(doc["userid"],doc["itemtype"]);
          mainstatus = true;
          //update all equals
          FirebaseFirestore.instance
              .collection('foundReports')
              .doc(doc["reportId"])
              .update({'status': true, 'matchesFids': report.userid});
        }
      });
      FirebaseFirestore.instance
          .collection('lostReports')
          .doc(report.reportId)
          .update({'status': mainstatus, 'matchesLids': ids});
    });
  }
}

sendNotification(String userid,String item) async {
  var snap = await FirebaseFirestore.instance.collection('users').doc(userid).get();
  var token = snap.get('deviceToken');
  callOnFcmApiSendPushNotifications(title:'REPORT MATCHED' ,body:'your $item report matched' ,Token:token);
}