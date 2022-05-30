import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/imagesOfGov.dart';
import 'package:intl/intl.dart';

import '../widgets/postForm.dart';
import 'home.dart';
import 'navBar.dart';

class safeplaces extends StatefulWidget {
  @override
  State<safeplaces> createState() => _safeplacesState();
}

class _safeplacesState extends State<safeplaces> {
  var selectedGov = null;
  var selectedReg = null ;
  var rate;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width:MediaQuery.of(context).size.width/2,
              child: DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                hint: Text('Governorate'),
                value: selectedGov,
                validator:(value) {
                  if(value == null){
                    return ('Governorate required!');
                  }
                },
                isExpanded: true,
                items: gov.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (governorate) {
                  if (governorate == 'Cairo') {
                    regions = cairo;
                  } else if (governorate == 'Giza') {
                    regions = giza;
                  } else if (governorate == 'Alexandria') {
                    regions = alexandria;
                  } else if (governorate == 'Dakahlia') {
                    regions = dakahlia;
                  } else if (governorate == 'Red Sea') {
                    regions = redSea;
                  } else if (governorate == 'Beheira') {
                    regions = beheira;
                  } else if (governorate == 'Fayoum') {
                    regions = fayoum;
                  } else if (governorate == 'Gharbiya') {
                    regions = gharbiya;
                  } else if (governorate == 'Ismailia') {
                    regions = ismailia;
                  } else if (governorate == 'Menofia') {
                    regions = menofia;
                  } else if (governorate == 'Minya') {
                    regions = minya;
                  } else if (governorate == 'Qaliubiya') {
                    regions = qaliubiya;
                  } else if (governorate == 'New Valley') {
                    regions = newValley;
                  } else if (governorate == 'Suez') {
                    regions = suez;
                  } else if (governorate == 'Aswan') {
                    regions = aswan;
                  } else if (governorate == 'Assiut') {
                    regions = assiut;
                  } else if (governorate == 'Beni Suef') {
                    regions = beniSuef;
                  } else if (governorate == 'Port Said') {
                    regions = portSaid;
                  } else if (governorate == 'Damietta') {
                    regions = damietta;
                  } else if (governorate == 'Sharkia') {
                    regions = sharkia;
                  } else if (governorate == 'South Sinai') {
                    regions = southSinai;
                  } else if (governorate == 'Kafr Al sheikh') {
                    regions = kafrAlsheikh;
                  } else if (governorate == 'Matrouh') {
                    regions = matrouh;
                  } else if (governorate == 'Luxor') {
                    regions = luxor;
                  } else if (governorate == 'Qena') {
                    regions = qena;
                  } else if (governorate == 'North Sinai') {
                    regions = northSinai;
                  } else if (governorate == 'Sohag') {
                    regions = sohag;
                  } else {
                    regions = [];
                  }
                  setState(() {
                    selectedReg = null;
                    selectedGov = governorate;
                  });
                },
              ),),
            Container(
        width:MediaQuery.of(context).size.width/2,
        child: DropdownButtonFormField<String>(
          dropdownColor: Colors.white,
          hint: Text('Region'),
          value: selectedReg,
          validator:(value) {
            if(value == null){
              return ('City required!');
            }
          },
          isExpanded: true,
          items: regions.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (regionn) {
            setState(() {
              selectedReg = regionn;
            });
          },
        ),
        ),
            Container(
                margin:EdgeInsets.fromLTRB(50, 30, 50, 30),
                child:FutureBuilder(
                  builder: (ctx, snapshot) {
                    // Checking if future is resolved or not
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If we got an error
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            '${snapshot.error} occured',
                            style: TextStyle(fontSize: 18),
                          ),
                        );

                        // if we got our data
                      } else if (snapshot.hasData) {
                        // Extracting data from snapshot object
                        final data = snapshot.data as Widget;
                        return Center(
                          child: data,
                        );
                      }
                    }

                    // Displaying LoadingSpinner to indicate waiting state
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },

                  // Future that needs to be resolved
                  // inorder to display something on the Canvas
                  future: getState(context, selectedGov, selectedReg),
                ),
                )
          ],
        ),
      ),
    );
  }
  Future<Widget> getState(BuildContext context , var gov , var reg) async {
   double ratio = await safePlaces(context,gov,reg);
   var stats = await stat(context, gov, reg);
    var safety ;
    var safetyColor = Colors.teal;
    print('rate = $ratio');
    if(ratio > 70){
      safety ='dangerous';
      safetyColor =Colors.red;
    }else if (ratio<70 && ratio>50){
      safety = 'unsafe';
      safetyColor = Colors.orange;
    }else if (ratio <=50 && ratio>30){
      safety ='safe' ;
      safetyColor = Colors.teal;

    }else {
      safety = 'very safe';
      safetyColor = Colors.green;
    }
    if(gov != null){
      return Column(
        children:[Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Container(child: Image.network(govImage.govIme[gov]!,fit:BoxFit.fill,width:80,height:85,)),
            Container(
              color:safetyColor,
              width:MediaQuery.of(context).size.width/2,
              padding:EdgeInsets.fromLTRB(10, 5, 0, 0),
              child: Column(
                children: [
                  Text('This place seems to be $safety',overflow:TextOverflow.clip,style: TextStyle(fontSize:15,color: Colors.white,fontWeight: FontWeight.normal),)
                  ,Container(
                    padding:EdgeInsets.fromLTRB(2, 6, 5, 0),
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.end,
                      children: [
                        Text('${ratio.toStringAsFixed(2)}%',overflow:TextOverflow.clip,style: TextStyle(fontSize:25,color: Colors.white),)
                      ],
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
          SizedBox(height:30,),
          stats,
        ],

      );

    }
    else{
      return Container(alignment:Alignment.center,child :Text('please select the location',style: TextStyle(fontSize:20,color: Colors.black38,),textAlign:TextAlign.center,));
    }

  }
 safePlaces(BuildContext context , var gov , var reg) async{
    int safety=0;
    QuerySnapshot<Map<String, dynamic>> snap;
    if(reg == null){
      snap = await FirebaseFirestore.instance.collection('posts').where('locationTown',isEqualTo:gov).get();
      safety=snap.size;
    }else{
      snap = await FirebaseFirestore.instance.collection('posts').where('location',isEqualTo:gov+' '+reg).get();
      safety=snap.size;
    }
    var all = await FirebaseFirestore.instance.collection('posts').get();
    double safeRatio = 0.0;
    safeRatio = (safety/all.size)*100;
    return safeRatio;
  }
  List <String> accidentType = ['murder','bodily injury','theft','fraud','drug' 'trafficking','Sexual Harassment','other'];
  stat ( BuildContext ctx ,var gov , var reg) async {
    var murder;
    var bodilyInjury;
    var theft;
    var fraud;
    var drug;
    var trafficking;
    var sexualHarassment;

    var snap1 = await FirebaseFirestore.instance.collection('posts').where('locationTown',isEqualTo:gov).where('CrimeType',isEqualTo:'murder').get();
    murder = snap1.size;
    var snap2 = await FirebaseFirestore.instance.collection('posts').where('locationTown',isEqualTo:gov).where('CrimeType',isEqualTo:'bodily injury').get();
    bodilyInjury = snap2.size;
    var snap3 = await FirebaseFirestore.instance.collection('posts').where('locationTown',isEqualTo:gov).where('CrimeType',isEqualTo:'theft').get();
    theft = snap3.size;
    var snap4 = await FirebaseFirestore.instance.collection('posts').where('locationTown',isEqualTo:gov).where('CrimeType',isEqualTo:'fraud').get();
    fraud = snap4.size;
    var snap5 = await FirebaseFirestore.instance.collection('posts').where('locationTown',isEqualTo:gov).where('CrimeType',isEqualTo:'drug').get();
    drug = snap5.size;
    var snap6 = await FirebaseFirestore.instance.collection('posts').where('locationTown',isEqualTo:gov).where('CrimeType',isEqualTo:'trafficking').get();
    trafficking = snap6.size;
    var snap7 = await FirebaseFirestore.instance.collection('posts').where('locationTown',isEqualTo:gov).where('CrimeType',isEqualTo:'Sexual Harassment').get();
    sexualHarassment = snap7.size;
    return Container(
      height: MediaQuery.of(ctx).size.height/2.5,
      child: SingleChildScrollView(
        child: DataTable(
            columns: [
              DataColumn(label: Text(
                  'Report type',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
              )),
              DataColumn(label: Text(
                  'num',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
              )),
            ],
            rows: [
        DataRow(cells: [
        DataCell(Text('Murder')),
        DataCell(Text('$murder')),
        ]),
        DataRow(cells: [
        DataCell(Text('Bodily injury')),
        DataCell(Text('$bodilyInjury')),
        ]),
        DataRow(cells: [
        DataCell(Text('Theft')),
        DataCell(Text('$theft')),
        ]),
        DataRow(cells: [
        DataCell(Text('Frauds')),
        DataCell(Text('$fraud')),
        ]),
        DataRow(cells: [
          DataCell(Text('Drugs')),
          DataCell(Text('$drug')),
        ]),
        DataRow(cells: [
          DataCell(Text('Trafficking ')),
          DataCell(Text('$trafficking')),
        ]),
        DataRow(cells: [
          DataCell(Text('Sexual Harassment')),
          DataCell(Text('$sexualHarassment')),
        ]),
  ],
        ),
      ),
    );
  }
}
