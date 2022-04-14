import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../view/myReport.dart';

class deleteReportClass{
  static deleteReport(BuildContext context,String reportId ,String reportKind){
    if ( reportKind == 'lost'){
      FirebaseFirestore.instance.collection('lostReports').doc(reportId).delete();
      Fluttertoast.showToast(
          msg: "Report deleted  successfully :) ",
          webBgColor: "linear-gradient(to right, #2e8b57, #2e8b57)",
          timeInSecForIosWeb: 5);

    }else
      {
        FirebaseFirestore.instance.collection('foundReports').doc(reportId).delete();
        Fluttertoast.showToast(
            msg: "Report deleted  successfully :) ",
            webBgColor: "linear-gradient(to right, #2e8b57, #2e8b57)",
            timeInSecForIosWeb: 5);

      }


  }
}