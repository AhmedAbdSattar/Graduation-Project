import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/imagesOfGov.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
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
                child:SingleChildScrollView(
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
                ),
                )
          ],
        ),
      ),
    );
  }
  Future<Widget> getState(BuildContext context , var gov , var reg) async {
   double ratio = await safePlaces(context,gov,reg);
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
      return Row(
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
              )
            ],
          ),
        )
        
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
}
