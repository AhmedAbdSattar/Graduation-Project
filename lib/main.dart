import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/posts.dart';

import 'view/login.dart';
//id of app one signal
//3f46a4e8-a914-4a74-91e5-6d00d1cdfea5
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
   /*  options: const FirebaseOptions(
       apiKey: " AIzaSyBCegfFrGVpenemnZiSRlyy4RkBUaE0MNQ ", // Your apiKey
       appId: "1:77512545458:android:9711b3e90f9e09088425ab", // Your appId
       messagingSenderId: "77512545458", // Your messagingSenderId
       projectId: "first-49c83", // Your projectId
       storageBucket: 'gs://first-49c83.appspot.com'

     ),*/
  );
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Zone App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
