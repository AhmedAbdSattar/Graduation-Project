import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import '../model/users.dart';
import '../view/home.dart';

class editProfileForm extends StatefulWidget {
  const editProfileForm({Key? key}) : super(key: key);

  @override
  editProfileState createState() => editProfileState();
}

class editProfileState extends State<editProfileForm> {
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

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
  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();

  // editing Controller
  final firstNameEditingController = new TextEditingController();
  final phoneEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //second color
    Color secondColor = HexColor("#2e8b57");
    //first name field
    firstNameEditingController.text ='${loggedInUser.firstName}';
    final firstNameField = TextFormField(
       // initialValue: loggedInUser.firstName,
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return (" Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Your Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    phoneEditingController.text ='${loggedInUser.phone}';
    //second name field
    final phoneField = TextFormField(
       // initialValue: loggedInUser.phone,
        autofocus: false,
        controller: phoneEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("phone cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          phoneEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Your Phone Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    emailEditingController.text = '${loggedInUser.email}';
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));


    //edit button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: secondColor,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
                updateInfo();
                Navigator.pushAndRemoveUntil(
                    (context),
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false);
          },
          child: Text(
            "Edit",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 280,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: 45),
                    firstNameField,
                    SizedBox(height: 20),
                    phoneField,
                    SizedBox(height: 20),
                    emailField,
                    SizedBox(height: 20),
                    signUpButton,
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }

updateInfo(){
    FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
      'email': emailEditingController.text,
      'firstName': firstNameEditingController.text,
      'phone': phoneEditingController.text,
    }).then((value) =>
        Fluttertoast.showToast(
        msg: "profile info edited :) ",
        webBgColor: "linear-gradient(to right, #2e8b57, #2e8b57)",
        timeInSecForIosWeb: 5));
    _auth.currentUser?.updateEmail(emailEditingController.text);
}

}
