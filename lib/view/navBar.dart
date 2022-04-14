import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/myReport.dart';
import 'package:flutter_application_1/view/posts.dart';
import 'package:flutter_application_1/view/profile.dart';
import 'package:flutter_application_1/view/safePlacesSearch.dart';
import 'package:hexcolor/hexcolor.dart';

import '../model/users.dart';
import 'login.dart';
import 'matchesReports.dart';

class navBar extends StatefulWidget {
  const navBar({Key? key}) : super(key: key);

  @override
  _navBarState createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  @override
  Color secondColor = HexColor("#2e8b57");
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

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(horizontal: 10);
    return Drawer(
      child: Material(
        color: Colors.teal,
        child: ListView(
          children: <Widget>[
            buildHeader(
              name: '${loggedInUser.firstName}',
              email: '${loggedInUser.email}',
              onClicked: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => profile(),
              )),
            ),
            const SizedBox(height: 1),
            Divider(color: Colors.white70),
            const SizedBox(height: 24),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 14),
                  buildMenuItem(
                    text: 'My Reports',
                    icon: Icons.archive,
                    onClicked: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => myReport()));
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Notifications',
                    icon: Icons.notifications_active,
                    onClicked: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => matchedReports()));
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Posts',
                    icon: Icons.now_wallpaper,
                    onClicked: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => posts()));
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Safe Places',
                    icon: Icons.admin_panel_settings,
                    onClicked: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => safeplaces()));
                    },
                  ),
                  const SizedBox(height: 10),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 14),
                  buildMenuItem(
                    text: 'Sign out',
                    icon: Icons.logout,
                    onClicked: () => logout(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Widget buildHeader({
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                const SizedBox(height: 1),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.teal,
                      ),
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        email,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.teal,
                      ),
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Tab to edit ',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

//ahmed@mail.com

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white12;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
