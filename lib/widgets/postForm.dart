

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

List<String> gov = [
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
//1
List<String> cairo = [
  "15 may city",
  "abdeen",
  "el darb elahmer",
  "ain shams",
  "amerya",
  "azbakya",
  "el basateen",
  "el gamaliya",
  "el khalifa",
  "maadi",
  "el marg",
  "el masara",
  "el matarya",
  "el mokattam",
  "el muski",
  'new cairo 1',
  'new cario 2',
  'new cario 3',
  'el weli',
  'el nozha',
  'el sahel',
  'el sharabiya',
  'el shurouk',
  'el segil',
  'el salam',
  'el sayeda zeinab',
  'el tebbin',
  'el zahar',
  'zamalek',
  'el zawya elhamra',
  'zeitoun',
  'bab el sheria',
  'bulaq',
  'dar el salam',
  'hadea el qobbah',
  'helwan',
  'nasr city 1',
  'nasr city 2',
  'badr city',
  'heliopolis',
  'old cairo',
  'manshiyat nasser',
  'qasr el nil',
  "road el farag",
  "shubra",
  "tura",
];
//2
List<String> giza = [
  'dokki',
  'pyramids',
  'agoiza',
  'el ayyat',
  'el badrashein',
  'el hawamedya',
  'giza',
  'el omranyia',
  'el wahat el bahariya',
  'el warraq',
  'sheik zayed city',
  'el saff',
  'atfeh',
  'talbia',
  'ossim',
  'bulaq el dakror',
  'imbaba',
  'kerdasa',
  '6th of october city',
];

//3
List<String> alexandria = [
  "15 may city",
  "Dekhela",
  "Amreya 1",
  "Amreya 2",
  "Ataren	",
  "Gomrok	",
  "Labban	",
  "Mansheya",
  "Montaza 1",
  "Montaza 2",
  "El Raml 1",
  "El Raml 2",
  "North Coast",
  "Bab Sharqi",
  "Borg El Arab",
  'Karmouz',
  'New Borg El Arab',
  'Port al-Basal',
  'Moharam Bek',
  'Sidi Gaber',
  'New Manshia',
  'Al Nasseria',
  'Upper and Lower Mergham',
  'The industrial zone in K 31, Desert Road',
  'Seibco',
  'Ajami',
  'Al Nahda and its expansions',
  'Ohm Zagheou',
];
//4
List<String> dakahlia = [
  'Aga',
  'Bilqas',
  'Damas',
  'Dikirnis',
  'El Gamaliya',
  'El Kurdi',
  'El Matareya',
  'El Senbellawein',
  'Gamasa',
  'Gogar',
  'Mansoura',
  'Manzala',
  'Mit Elkorama',
  'Mit Ghamr',
  'Mit Salsil',
  'Nabaroh',
  'Sherbin',
  'Temay El Amdeed',
  'Talkha',
];

List<String> Damietta = [
  'el zarqa',
  'damietta',
  'damietta 1 ',
  'damietta 2',
  'faraskur',
  'kafr el battikh',
  'kafr saad',
  'new damietta',
  'ras el bar',
];
//5
List<String> redSea = [
  'hurdaga 1',
  'hurdaga 2',
  'el qusair',
  'shalateen',
  'halaib',
  'marsa alam',
  'ras gharib',
  'safaga',
];

//6
List<String> beheira = [
  'Abu El Matamir',
  'Abu Hummus',
  'El Delengat',
  'Mahmoudiyah',
  'Rahmaniya',
  'Badr',
  'Damanhour',
  'West Nubariyah',
  'Hosh Essa',
  'Edku',
  'Itay El Barud',
  'Kafr El Dawwar',
  'Kom Hamada',
  'Rosetta',
  'Shubrakhit',
  'Natrn Valley',
];
//7
List<String> fayoum = [
  'Faiyum',
  'Faiyum 1&2',
  'ibsheway',
  'itsa',
  'new Faiyum',
  'sinnuris',
  'tamiya',
  'yousef el seddeek',
];
//8
List<String> gharbiya = [
  'El Mahalla El Kubra',
  'El Mahalla El Kubra 1',
  'El Mahalla El Kubra 2 ',
  'El Mahalla El Kubra 3',
  'Kafr El Zayat',
  'Samanoud',
  'Tanta',
  'Zifta',
  'El Santa',
  'Kotoor',
  'Basyoun',
];
//9
List<String> ismailia = [
  'Abu Suwir El Mahata',
  'ismalia',
  'el qantra',
  'el qantra el sharqiya',
  'new kasaseen',
  'tell el kebir',
  'fayid',
];
//10
List<String> menofia = [
  'Shibin El Kom',
  'Menouf',
  'Ashmoun',
  'Sers El Lyan',
  'Tala',
  'El Bagour',
  'El Shohada',
  'Sadat City',
  'Quesna',
  'Birket El Sab',
  'Shanawan',
];

//11
List<String> minya = [
  'Abu Qirqas',
  'El Idwa',
  'Minya',
  'New Minya',
  'Beni Mazar',
  'Deir Mawas',
  'Maghagha',
  'Mallawi',
  'Matai',
  'Samalut',
];

//12
List<String> qaliubiya = [
  'Banha',
  'Khanka',
  'Qaha',
  'Qalyub',
  'Shibin El Qanater',
  'Shubra El Kheima',
  'Tukh',
  'El Qanater El Khayreya',
  'Kafr Shukr',
  'Obour City',
  'Khusus',
];
//13
List<String> newValley = [
  'kharga',
  'balat',
  'dakhla',
  'farafra',
  'baris ',
];

//14
List<String> suez = [
  'arabeen',
  'ganayen',
  'seuz',
  'attaka',
  'faisal',
];
//15
List<String> aswan = [
  "Abu Simbel",
  "Aswan",
  "Aswan 1",
  "Aswan 2",
  "Daraw",
  "Edfu",
  "Kom Ombo",
  "New Aswan",
  "New Tushka",
  "Nasser City",
];

//16
List<String> assiut = [
  'Abnub',
  'Abu Tig',
  'Abu Tig',
  'El Badari',
  'El Fath',
  'El Ghanayem',
  'El Qusiya',
  'Asyut',
  'Asyut 1',
  'Asyut 2',
  'Dairut',
  'New Asyut',
  'Manfalut',
  'Sahel Selim',
  'Sodfa',
];
//17
List<String> portSaid = [
  'el dawahy',
  'el arab',
  'el ganoub',
  'el ganoub 2',
  'el manakh',
  'el mansara',
  'el sharq',
  'el zohur',
  'port faud',
  'port fuad 2',
  'mubark east',
];

//18
List<String> beniSuef = [
  'el fashn',
  'el wasta',
  'beni seuf',
  'biba',
  'innasiya',
  'new beni seuf',
  'nasser',
  'sumusta el wafq',
];
//19
List<String> damietta = [
  'el zarqa',
  'damietta',
  'damietta 1 ',
  'damietta 2',
  'faraskur',
  'kafr el battikh',
  'kafr saad',
  'new damietta',
  'ras el bar',
];

//20
List<String> sharkia = [
  '10th of Ramadan',
  'Abu Hammad',
  'Abu Kebir',
  'Awlad Saqr',
  'Bilbeis',
  'Diyarb Negm',
  'El Husseiniya',
  'El Ibrahimiya',
  'El Qurein',
  'Faqous',
  'Hihya',
  'Kafr Saqr',
  'Mashtool El Souk',
  'Minya El Qamh',
  'El Salheya El Gedida',
  'Zagaziq',
];
//21
List<String> southSinai = [
  'Dahab',
  'El Tor',
  'Nuweiba',
  'Saint Catherine',
  'Sharm El Sheikh',
  'Taba',
  'Ras sudr',
];

//22
List<String> kafrAlsheikh = [
  'El Hamool',
  'Baltim',
  'Biyala',
  'Desouk',
  'Fuwwah',
  'Kafr El Sheikh',
  'Metoubes',
  'Qallin',
  'El Reyad',
  'Sidi Salem',
];

//23
List<String> matrouh = [
  'el dabaa',
  'el alamein',
  'el hamam',
  'el negailia',
  'north coast',
  'sallum',
  'mersa matruh',
  'sidi barrani',
  'siwa oasis',
];

//24
List<String> luxor = [
  'qurna',
  'luxor',
  'armant',
  'esna',
  'tiba',
];

//25
List<String> qena = [
  'abu tesht',
  'el waqf',
  'dishna',
  'farshut',
  'nad hammadi',
  'naqada',
  'qift',
  'qena',
  'qus',
];
//26
List<String> northSinai = [
  'El Arish 1',
  'El Arish 2',
  'El Arish 3',
  'El Arish 4',
  'Nekhel',
  'Rafah',
  'Bir al-Abed',
  'Hassana ',
  'Sheikh Zuweid',
];
//27
List<String> sohag = [
  'Akhmim (Ipu or Khent-Min or Khemmis or Panopolis)',
  'Dar El Salam',
  'El Balyana',
  'El Mansha',
  'El Maragha',
  'El Usayrat',
  'Girga (Tjeny or Thinis)',
  'Juhayna',
  'Sakulta',
  'Sohag',
  'Tahta',
  'Tima',
];

final _formKey = GlobalKey<FormState>();
final title = new TextEditingController();
final description = new TextEditingController();
List<String> regions = [];
var selectedGovernorate;
var selectedregion ;
File? _image;
showFormDialog(BuildContext context)  {
  return  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
             // width: MediaQuery.of(context).size.width/2,
             // height: MediaQuery.of(context).size.height/2,
              child: AlertDialog(
                content: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        dropdownColor: Colors.teal,
                        hint: Text('Governorate'),
                        value: selectedGovernorate,
                        isExpanded: true,
                        validator:(value) {
                          if(value == null){
                            return ('Governorate required!');
                          }

                        } ,
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
                            selectedregion = null;
                            selectedGovernorate = governorate;
                          });
                        },
                      ),
                      // gov Dropdown Ends here
                      // Region Dropdown
                      DropdownButtonFormField<String>(
                        dropdownColor: Colors.teal,
                        hint: Text('Region'),
                        value: selectedregion,
                        validator:(value) {
                          if(value == null){
                            return ('City required!');
                          }
                      } ,
                        isExpanded: true,
                        items: regions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (regionn) {
                          if(regionn!.isEmpty){
                            return ;
                          }
                          setState(() {
                            selectedregion = regionn;
                          });
                        },

                      ),
                      SizedBox( height: 30),
                      TextFormField(
                          autofocus: false,
                          controller: title,
                          keyboardType: TextInputType.name,
                          maxLength: 100,
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{3,}$');
                            if (value!.isEmpty) {
                              return (" Title cannot be Empty");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter Valid title(Min. 3 Character)");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            title.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Post title",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                      TextFormField(
                        autofocus: false,
                        controller: description,
                        keyboardType: TextInputType.name,
                        maxLength: 450,
                        maxLines: 5,
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return (" Post description cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid Description(Min. 3 Character)");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          description.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Post description",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('Pick image:',style: TextStyle(fontSize: 15,color: Colors.black54),),
                          SizedBox(width: 10,),
                          MaterialButton(
                            elevation: 3,
                            hoverColor: Colors.black54,

                            onPressed: ()  async{
                                PickedFile? image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
                                setState((){
                                  _image = File(image!.path);
                                });
                                  print(_image!.toString());

                                },

                    child: Row(children: [Icon(Icons.add_a_photo),Text('Pick image or video',style: TextStyle(fontSize: 10 ,color: Colors.white),) ],),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      _image != null?
                      Container(
                          child: Image.network(_image!.path),
                      ):
                          Container(child:  Image.asset('logo.png'),)
                    ],
                  ),
                ),
                scrollable: true,
               // actionsAlignment:MainAxisAlignment.center ,
                actions: [
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.teal,
                    child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                         postData(context,selectedregion,selectedGovernorate,
                           title.text, description.text);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.post_add,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          const Text(
                            "Post",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      });

}

postData(BuildContext context,var locationCity,var locationTown, String title, String description) {
  if (_formKey.currentState!.validate()) {
    print('Location is $locationCity');
    print('Location is $locationTown');
    print('title is $title');
    print('desc is $description');
    Navigator.of(context).pop();
  }
}

