

class lostReportModel {
  String? date;
  String? itembrand;
  String? itemcolor;
  String? itemtype;
  String? location;
  String? serialnumber;

  String? useremail;
  String? userid;
  String? username;
  String? userphone;

  bool? status = false;

  List<String>? matchesLids = [];
  String? Reportkind = 'lost';
  String? reportId;

  lostReportModel(
      {this.reportId,
      this.date,
      this.itembrand,
      this.itemcolor,
      this.itemtype,
      this.location,
      this.serialnumber,
      this.useremail,
      this.userid,
      this.username,
      this.userphone,
      this.matchesLids,
      this.Reportkind,
      this.status});

  // receiving data from server
  factory lostReportModel.fromMap(map) {
    return lostReportModel(
        reportId: map['reportId'],
        date: map['date'],
        itembrand: map['itembrand'],
        itemcolor: map['itemcolor'],
        itemtype: map['itemtype'],
        location: map['location'],
        serialnumber: map['serialnumber'],
        useremail: map['useremail'],
        userid: map['userid'],
        username: map['username'],
        userphone: map['userphone'],
        Reportkind: map['ReportKind'],
        status: map['status'],
        matchesLids: ['matchesLids']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'reportId': reportId,
      'date': date,
      'itembrand': itembrand,
      'itemcolor': itemcolor,
      'itemtype': itemtype,
      'location': location,
      'serialnumber': serialnumber,
      'useremail': useremail,
      'userid': userid,
      'username': username,
      'userphone': userphone,
      'Reportkind': Reportkind,
      'status': status,
      'matchesLids': matchesLids,
    };
  }
}
