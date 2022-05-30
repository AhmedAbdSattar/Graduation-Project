import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/controller/matching.dart';
import 'package:flutter_application_1/model/lostReports.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../model/foundReports.dart';
import '../model/users.dart';
import '../view/home.dart';
import 'postForm.dart';

class reportForm extends StatefulWidget {

  @override
  State<reportForm> createState() => _reportFormState();
}
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
Color secondColor = Colors.teal;

List<String> regions = [];
List<String> types = [];
List<String> brands = [];
//main categories
List<String> categories = [
  'Electronics',
  'Cards',
  'Clothes & Accessories',
  'Sports Accessories',
  'Pets'
];
//main types
List<String> electronicsTypes = [
  'Stop watch',
  'charger',
  'Calculator',
  'Camera',
  'Dvd player',
  'Earphones',
  'Smartphone',
  'Tablet',
  'iPod',
  'Microphone',
  'Mouse',
  'Radio',
  'Smart Watch',
  'Laptop'
];
List<String> cardsTypes = [
  'Id card',
  'Passport',
  'Health Card',
  'Transport Card',
  'Credit card',
  'Driving License'
];
List<String> clothesAccessoriesTypes = [
  'Sweater',
  'Glasses',
  'Sun glasses',
  'Bag',
  'Dress',
  'Hoodies',
  'T-shirt',
  'Shorts',
  'Skirt',
  'Jeans',
  'Shoes',
  'Coat',
  'High heels',
  'Suit',
  'Cap',
  'Socks',
  'Shirt',
  'Scarf',
  'Swimsuit',
  'Hat',
  'Gloves',
  'Jacket',
  'Long coat',
  'Boots',
  'Tie',
  'Polo shirt',
  'Leather jackets'
];
List<String> sportsAccessoriesTypes = [
  'Ball',
  'Sports Gloves',
  'Helmet',
  'Tennis Racket',
  'Sport shoes'
];
List<String> petsTypes = [
  'Cats',
  'Dogs',
  'Birds',
  'Rabbits',
  'Horses',
  'Turtles',
  'Fish',
  'Pigs',
  'Rats and Mice'
];
//electronic brands
List<String> stopSmartwatch = [
  'Amazfit',
  'Apple',
  'Samsung',
  'Fitbit',
  'Fossil',
  'Garmin',
  'GOQii',
  'Huawei',
  'Xiaomi',
  'Ambrane',
  'Casio',
  'Citizen',
  'Diesel',
  'Dizo',
  'Fastrack',
  'Fire-Boltt',
  'Gionee',
  'Honor',
  'Huami',
  'Lcare',
  'Lenovo',
  'Louis Vitton',
  'Maxima',
  'Mi',
  'Michael Kors',
  'Misfit',
  'Motorola',
  'Noise',
  'OnePlus',
  'Oppo',
  'Puma',
  'Realme',
  'Redmi',
  'REEBOK',
  'Ticwatch',
  'Vivo',
  'Others'
];
//Calculator Charger Dvd player Projector Philips LG Samsung Yamaha Mitashi Akai DXP Enem GPX Shrih Takai Unbranded
List<String> chargerTypes = [
  'USB-Type A',
  'USB- Type B',
  'USB- Type C',
  'Mini-USB',
  'Micro-USB',
  'USB 3.0',
  'Lightning (Iphone)',
  'Others'
];
List<String> cameraBrand = [
  'Canon',
  'Nikon',
  'Sony',
  'Fujifilm',
  'Panasonic',
  'Olympus',
  'Leica',
  'GoPro',
  'Pentax',
  'Kodak',
  'Polaroid',
  'Ricoh',
  'Hasselblad',
  'Others'
];
List<String> earphonesBrands = [
  'Jabra',
  'Sennheiser',
  'Shure',
  'Sony',
  'Bowers & Wilkins',
  'RHA',
  'FiiO',
  'Bose',
  'JBL',
  'Bang & Olufsen',
  'Apple',
  'Beats',
  'Etymotic Research',
  'Skullcandy',
  'Xiaomi',
  'Samsung',
  'Others'
];
List<String> smartPhoneTabletBrands = [
  'Samsung',
  'Apple',
  'Huawei',
  'Nokia',
  'Sony',
  'LG',
  'HTC',
  'Motorola',
  'Lenovo',
  'Xiaomi',
  'Google',
  'Honor',
  'Oppo',
  'Realme',
  'OnePlus',
  'vivo',
  'Meizu',
  'BlackBerry',
  'Asus',
  'Alcatel',
  'ZTE',
  'Microsoft',
  'Vodafone',
  'Energizer',
  'Cat',
  'Sharp',
  'Micromax',
  'Infinix',
  'TCL',
  'Ulefone',
  'Tecno',
  'BLU',
  'Acer',
  'Wiko',
  'Panasonic',
  'Plum',
  'Others'
];
List<String> microphoneRadio = [
  'Akai',
  'AKG',
  'Audio-Technica',
  'Behringer',
  'Beyerdynamic',
  'Blue Microphones',
  'Brauner',
  'Brüel & Kjær',
  'Core Sound LLC',
  'DPA',
  'Earthworks',
  'Electro-Voice',
  'Fostex',
  'Gauge Precision Instruments',
  'Gentex Corp',
  'Georg Neumann GmbH',
  'Grundig',
  'Heil Sound',
  'JZ Microphones',
  'Lauten Audio',
  'Line 6',
  'Manley Laboratories',
  'Others'
];
List<String> laptopMouseBrands = [
  'Sony',
  'Toshiba',
  'Acer',
  'Dell',
  'Lenovo',
  'HP',
  'Asus',
  'Microsoft',
  'Apple',
  'Samsung',
  'SteelSeries',
  'Razer',
  'ROCCAT',
  'HyperX',
  'Asus',
  'Vaxee',
  'Corsair'
];
List<String> calculatorbrands = [
  'Canon',
  'Casio',
  'Citizen',
  'Hewlett-Packard',
  'Sharp',
  'Texas Instruments',
  'Others'
];
List<String> dvdPlayer = [
  'Philips',
  'LG',
  'Samsung',
  'Yamaha',
  'Mitashi',
  'Akai',
  'DXP',
  'Enem',
  'GPX',
  'Shrih',
  'Takai',
  'Unbranded',
  'Others'
];
//cards
List<String> idcardBrands = [
  'personal id',
  'Regular passport',
  'Special passport',
  'Diplomatic passport',
  'Service passport',
  'Others'
];
List<String> healthTransportCard = [
  'Student Health Card',
  'Student Metro Card',
  'Student Bus Card',
  'Others'
];
List<String> creditCardBrands = [
  'Credit Cards',
  'Debit Cards',
  'Salaries Cards',
  'Government Payroll Cards',
  'Pre-Paid Cards',
  'Others'
];
List<String> drivingCards = ['Car License', 'Motorcycles'];
//clothes
List<String> clothesAccessoriesBrands = [
  'Nike',
  'GUCCI',
  'Louis Vuitton',
  'Adidas',
  'Chanel',
  'ZARA',
  'UNIQLO',
  'H&M',
  'Cartier',
  'Hermès',
  'Rolex',
  'Dior Tiffany & Co.',
  'Chow Tai Fook',
  'COACH',
  'Puma',
  'Ray-Ban',
  'Max',
  'Dott',
  'Others'
];
List<String> sportsAccessoriesBrands = [
  'Adidas',
  'Nike',
  'Asics',
  'Puma',
  'Under Armour',
  'Fila',
  'Reebok',
  'AGV',
  'Shoei',
  'Shark',
  'Arai',
  'Caberg',
  'Studds',
  'HEAD',
  'Wilson',
  'Yonex',
  'Babolat',
  'Volkl',
  'ProKennex',
  'Prince',
  'Dunlop',
  'Tecnifibre',
  'Pacific',
  'Gamma',
  'Donnay',
  'Solinco',
  'Others'
];
//pets brands
List<String> catsBrands = [
  'Chausie',
  'African Wildcat',
  'Shirazi',
  'Nile Valley',
  'Egyptian Cat',
  'Savannah Cat',
  'Egyptian Mau',
  'Abyssinian',
  'Others'
];
List<String> dogsBrands = [
  'German ',
  'Boxer',
  'Labrador',
  'Golden',
  'Great Dane',
  'Bernard',
  'Rottweiler',
  'Doberman',
  ' Pit bull',
  'Dalmatian',
  ' Neapolitan Mastiff',
  'Bulldog',
  'Husky',
  'Others'
];
List<String> birdsBrands = [
  'Parrot',
  'Owl',
  'Ostrich',
  'Nightingale',
  'Hoopoe',
  'Goose',
  'Falcon',
  'Eagle',
  'Dove',
  'Bulbul',
  'Others'
];
List<String> rabbits = [
  'Mini Rex',
  'Holland Lop',
  'Dutch Lop',
  'Dwarf Hotot',
  'Mini Lop',
  'Mini Satin',
  'Netherland Dwarf',
  'Polish',
  'Lionhead',
  'Polish',
  'Jersey Wooly',
  'Californian',
  'Harlequin',
  'Havana',
  'Standard Chinchilla',
  'Himalayan',
  'Others'
];
List<String> horses = [
  'Arabian',
  'American Quarter',
  'Thoroughbred',
  ' Appaloosa ',
  'Morgan',
  'Warmbloods ',
  'Ponies ',
  'Grade Horses ',
  'Gaited Breeds ',
  ' Draft Breeds ',
  'Others '
];
List<String> turtles = [
  'Red-Eared Slider African Sideneck',
  'Eastern Box',
  'Western Painted',
  'Mississippi Map',
  'Common Musk',
  'Spotted',
  'Yellow-Bellied Slider',
  'Reeve"s',
  'Wood',
  'Others'
];
List<String> fish = [
  'Neon Tetra',
  'Guppies',
  'Oscar',
  'Mollies',
  'Zebra Danios',
  'Platies',
  'Cherry Barb',
  'Pearl Gourami',
  'Swordtails',
  'Discus',
  'Killifish',
  'Bettas',
  'Plecostomus',
  'Rainbowfish',
  'Corydoras Catfish',
  'Goldfish',
  'Angelfish',
  'Others'
];
List<String> pigs = [
  'American Yorkshire',
  'Lacombe',
  ' Large White ',
  ' Large Black ',
  ' Middle White ',
  ' Mora Romagnola ',
  ' Oxford Sandy and Black ',
  'Swedish Landrace ',
  'Turopolje ',
  'Others'
];
List<String> ratsAndMice = [
  'Syrian Hamster',
  'Dwarf Hamster',
  'Chinese Hamster',
  'Mongolian Gerbil',
  'Fancy Mouse',
  'Common Rat',
  'Guinea Pig',
  'Chinchilla',
  'African Dormouse',
  'Common Degu',
  'Others'
];
List<String> ucolors = [
  'black',
  'white',
  'red',
  'green',
  'grey',
  'blue',
  'brown',
  'cyan',
  'yellow',
  'orange',
  'purple',
  'pink',
  'lime'
];
List<Color> colorsList = [
  Color(0xFF000000),
  Color(0xffffffff),
  Color(0xfff44336),
  Color(0xff4caf50),
  Color(0xff9e9e9e),
  Color(0xFF0D47A1),
  Color(0xFF3E2723),
  Color(0xff00bcd4),
  Color(0xffffeb3b),
  Color(0xffff9800),
  Color(0xff9c27b0),
  Color(0xffe91e63),
  Color(0xffcddc39)
];


final TextEditingController idNumber = new TextEditingController();
var  selectedGovernorate = null ;
var selectedregion = null;
var CategorySelected = null;
var selectedType = null;
var selectedBrand = null;
var selectedColor = null ;
DateTime selectedDate = DateTime.now();
final formKey2 =   GlobalKey<FormState>();
class _reportFormState extends State<reportForm> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20.0),
      children: [
        Form(
          key: formKey2,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                dropdownColor: Colors.teal,
                hint: Text('Category'),
                value: CategorySelected,
                isExpanded: true,
                validator:(value) {
                  if(value == null){
                    return ('Category required!');
                  }
                } ,
                items: categories.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (category) {
                  if (category == 'Electronics') {
                    types = electronicsTypes;
                  } else if (category == 'Cards') {
                    types = cardsTypes;
                  } else if (category == 'Clothes & Accessories') {
                    idNumber.text = 'unhave';
                    types = clothesAccessoriesTypes;
                  } else if (category == 'Sports Accessories') {
                    idNumber.text = 'unhave';
                    types = sportsAccessoriesTypes;
                  } else if (category == 'Pets') {
                    idNumber.text = 'unhave';
                    types = petsTypes;
                  } else {
                    types = [];
                  }
                  setState(() {
                    selectedType = null;
                    selectedBrand = null;
                    CategorySelected = category;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.teal,
                hint: Text('Type'),
                value: selectedType,
                validator:(value) {
                  if(value == null){
                    return ('Type required!');
                  }
                } ,
                isExpanded: true,
                items: types.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (type) {
                  if (type == 'Stop watch' || type == 'Smart Watch') {
                    brands = stopSmartwatch;
                  } else if (type == 'charger') {
                    brands = chargerTypes;
                  } else if (type == 'Calculator') {
                    brands = calculatorbrands;
                  } else if (type == 'Dvd player') {
                    brands = dvdPlayer;
                  } else if (type == 'Camera') {
                    brands = cameraBrand;
                  } else if (type == 'Earphones') {
                    brands = earphonesBrands;
                  } else if (type == 'Smartphone' ||
                      type == 'iPod' ||
                      type == 'Tablet') {
                    brands = smartPhoneTabletBrands;
                  } else if (type == 'Microphone' || type == 'Radio') {
                    brands = microphoneRadio;
                  } else if (type == 'Laptop' || type == 'Mouse') {
                    brands = laptopMouseBrands;
                  } else if (type == 'Stop watch' || type == 'Smart Watch') {
                    brands = stopSmartwatch;
                  } else if (type == 'Id card' || type == 'Passport') {
                    brands = idcardBrands;
                  } else if (type == 'Health Card' || type == 'Transport Card') {
                    brands = healthTransportCard;
                  } else if (type == 'Credit card') {
                    brands = creditCardBrands;
                  } else if (type == 'Driving License') {
                    brands = drivingCards;
                  } else if (clothesAccessoriesTypes.contains(type)) {
                    brands = clothesAccessoriesBrands;
                  } else if (sportsAccessoriesTypes.contains(type)) {
                    brands = sportsAccessoriesBrands;
                  } else if (type == 'Cats') {
                    brands = catsBrands;
                  } else if (type == 'Dogs') {
                    brands = dogsBrands;
                  } else if (type == 'Birds') {
                    brands = birdsBrands;
                  } else if (type == 'Rabbits') {
                    brands = rabbits;
                  } else if (type == 'Horses') {
                    brands = horses;
                  } else if (type == 'Turtles') {
                    brands = turtles;
                  } else if (type == 'Fish') {
                    brands = fish;
                  } else if (type == 'Pigs') {
                    brands = pigs;
                  } else if (type == 'Rats and Mice') {
                    brands = ratsAndMice;
                  } else {
                    brands = [];
                  }
                  setState(() {
                    selectedBrand = null;
                    selectedType = type;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.teal,
                hint: Text('Brand/Id'),
                value: selectedBrand,
                validator:(value) {
                  if(value == null){
                    return ('brand required!');
                  }
                } ,
                isExpanded: true,
                items: brands.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (brand) {
                  setState(() {
                    selectedBrand = brand;
                  });
                },
              ),
              Visibility(
                visible:
                CategorySelected == 'Cards' || CategorySelected == 'Electronics'
                    ? true
                    : false,
                child: TextFormField(
                  autofocus: false,
                  controller: idNumber,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null) {
                      return (' serial Number required!');
                    }
                    return null;
                  },
                  onSaved: (value) {
                    idNumber.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.tag),
                    hintText: CategorySelected == 'Cards'
                        ? 'Enter Your Id Number'
                        : 'Enter serial Number',
                  ),
                ),
              ),
              // gov Dropdown
              DropdownButtonFormField<String>(
                dropdownColor: Colors.teal,
                hint: Text('Governorate'),
                value: selectedGovernorate,
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
                    selectedregion = regionn;
                  });
                },
              ),
              // Region Dropdown Ends here
              DropdownButtonFormField<Color>(
                dropdownColor: Colors.teal,
                hint: Text('Main Color'),
                value: selectedColor,
                validator:(value) {
                  if(value == null){
                    return ('Color required!');
                  }
                },
                isExpanded: true,
                items: colorsList.map((value) {
                  return DropdownMenuItem<Color>(
                    value: value,
                    child: Row(
                      children: [
                        Icon(Icons.rectangle, size: 30, color: value),
                        SizedBox(width: 20),
                        Text(ucolors[colorsList.indexOf(value)])
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (scolor) {
                  setState(() {
                    selectedColor = scolor;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              setState(() {
                selectedDate = DateTime.now();
              });
            },
            child: Text(
              "TODAY",
              style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: ScrollDatePicker(
            selectedDate: selectedDate,
            minimumDate: DateTime(2021),
            maximumDate: DateTime.now(),
            style: DatePickerStyle(
              selectedTextStyle: TextStyle(color: Colors.teal),
              textStyle: TextStyle(color: Colors.black),
            ),
            locale: DatePickerLocale.enUS,
            onDateTimeChanged: (DateTime value) {
              setState(() {
                selectedDate = value;
              });
            },
          ),
        ),
        SizedBox(height: 30),
        Container(
          decoration: BoxDecoration( borderRadius: BorderRadius.circular(30),color: secondColor,),
          child: MaterialButton(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              onPressed: () {
                postDetailsToFirestoreLost();
                setState(() {
                  //Match Function
                  selectedGovernorate = null;
                  selectedregion = null;
                  CategorySelected = null;
                  selectedType = null;
                  selectedBrand = null;
                  selectedColor = null;
                });
              },
              child: Text(
                "Report As Lost",
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
              )),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration( borderRadius: BorderRadius.circular(30),color: secondColor,),
          child: MaterialButton(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              onPressed: () {
                postDetailsToFirestoreFound();
                setState(() {
                  //Match Function
                  selectedGovernorate = null;
                  selectedregion = null;
                  CategorySelected = null;
                  selectedType = null;
                  selectedBrand = null;
                  selectedColor = null;
                });
              },
              child: Text(
                "Report As Found",
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
              )),
        ),
      ],
    );
  }

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  lostReportModel lostReport = lostReportModel();
  foundReportModel foundReport = foundReportModel();
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  matchingAlgorithem match = matchingAlgorithem();
  postDetailsToFirestoreLost() async {
    if(formKey2.currentState!.validate()){
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = _auth.currentUser;

      // writing all the values
      lostReport.useremail = user!.email;
      lostReport.userid = user.uid;
      lostReport.username = loggedInUser.firstName;
      lostReport.userphone = loggedInUser.phone;
      lostReport.itemtype = selectedType + ' ' + CategorySelected;
      lostReport.itembrand = selectedBrand;
      lostReport.serialnumber = idNumber.text;
      lostReport.date = selectedDate.day.toString() +
          ' / ' +
          selectedDate.month.toString() +
          ' / ' +
          selectedDate.year.toString();
      lostReport.location = selectedregion + ' ' + selectedGovernorate;
      lostReport.itemcolor = selectedColor.toString();
      lostReport.status = false;
      lostReport.matchesLids;
      lostReport.Reportkind = 'lost';

      final collRef = await firebaseFirestore.collection('lostReports');
      var docReference = collRef.doc();
      lostReport.reportId = docReference.id;
      docReference.set(lostReport.toMap());
      Fluttertoast.showToast(
          msg: "Report added  successfully :) ",
          webBgColor: "linear-gradient(to right, #2e8b57, #2e8b57)",
          timeInSecForIosWeb: 5);
      match.matchingLost(lostReport);

      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    }
  }
  postDetailsToFirestoreFound() async {
    if(formKey2.currentState!.validate()){
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = _auth.currentUser;

      // writing all the values
      foundReport.useremail = user!.email;
      foundReport.userid = user.uid;
      foundReport.username = loggedInUser.firstName;
      foundReport.userphone = loggedInUser.phone;
      foundReport.itemtype = selectedType + ' ' + CategorySelected;
      foundReport.itembrand = selectedBrand;
      foundReport.serialnumber = idNumber.text;
      foundReport.date = selectedDate.day.toString() +
          ' / ' +
          selectedDate.month.toString() +
          ' / ' +
          selectedDate.year.toString();
      foundReport.location = selectedregion + ' ' + selectedGovernorate;
      foundReport.itemcolor = selectedColor.toString();
      foundReport.status = false;
      foundReport.Reportkind = 'found';
      foundReport.matchesFids;

      final collRef = await firebaseFirestore.collection('foundReports');
      var docReference = collRef.doc();
      foundReport.reportId = docReference.id;
      docReference.set(foundReport.toMap());
      Fluttertoast.showToast(
          msg: "Report added  successfully :) ",
          webBgColor: "linear-gradient(to right, #2e8b57, #2e8b57)",
          timeInSecForIosWeb: 5);
      match.matchingFound(foundReport);

      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    }
  }
}
