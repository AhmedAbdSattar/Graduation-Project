import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class deletePost{
  static deletePosts(BuildContext context , String postId, String kind, String postImage) async{
    var collection = 'posts';
    if(kind == 'nor'){
      collection ='normalPosts';
    }
   var snap = await FirebaseFirestore.instance.collection(collection).doc(postId).get();
   var commentsList =snap.get('comments');
   for(var item in commentsList){
     await FirebaseFirestore.instance.collection('comments').doc(item).delete();
   }

   await FirebaseFirestore.instance.collection(collection).doc(postId).delete().whenComplete(() => Fluttertoast.showToast(
       msg: "Post deleted  successfully :) ",
       webBgColor: "linear-gradient(to right, #2e8b57, #2e8b57)",
       timeInSecForIosWeb: 5));
   await FirebaseStorage.instance.refFromURL(postImage).delete();

  }
}