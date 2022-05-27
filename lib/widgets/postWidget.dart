
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/Commets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/controller/deletePost.dart';

 Widget showPost(BuildContext context,String postOwnerId,String postID,String postOwner,String PostDescription,String PostImage,String postLocation,Timestamp postDate,List<dynamic> likesList,List commentsList,String kind, {crimeType}){
  DateTime Date = postDate.toDate();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
  String time =dateFormat.format(Date);
  print(postOwnerId);
  User? user = FirebaseAuth.instance.currentUser;
  bool? isliked;
  var collection ='posts';
  if (kind == 'nor'){
    collection = 'normalPosts';
  }
  return Stack(
    children: [
      StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.fromLTRB(10, 22, 10, 5),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 1.0),
              ],color: Colors.white),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //name
                  Text(postOwner,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:kind=='acc'?Colors.red:Colors.teal),overflow: TextOverflow.clip,),
                  //time
                  Text(postLocation+'  '+'$time',style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,color:Colors.black54),overflow: TextOverflow.clip,),
                  //Image
                  SizedBox(height: 5,),
                  Visibility( visible:PostImage=='notfound'?false:true,child: Center(child: Image.network(PostImage,fit:BoxFit.cover,))),
                  //React
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // likes icon
                        IconButton(
                            onPressed: (){
                              if(likesList.contains(user!.uid)){
                                setState(() {
                                  isliked =false;
                                  FirebaseFirestore.instance.collection(collection).doc(postID).update({'likes': FieldValue.arrayRemove([user.uid])});
                                });
                              }else{
                                setState(() {
                                  isliked =true;
                                  FirebaseFirestore.instance.collection(collection).doc(postID).update({'likes': FieldValue.arrayUnion([user.uid])});
                                });
                              }
                            },
                            icon: likesList.contains(user!.uid)?Icon(Icons.warning ,color:Colors.red,size:30,):Icon(Icons.warning_amber_outlined,color:Colors.black,size: 30,)),
                        Text('${likesList.length}  warning',style: TextStyle(fontSize: 12,color: Colors.black87,fontWeight:FontWeight.normal ),), SizedBox(width: 5,),
                        //Comments Icon
                        IconButton(onPressed: ()=>commentsWidget(context, postID,kind), icon: Icon(Icons.comment,color: Colors.black,))
                      ],
                    ),
                  ),
                  //description
                  Text(PostDescription,style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color:Colors.black),overflow: TextOverflow.clip,),

                ],
              ),

            );
          }
      ),      Visibility(
        visible:postOwnerId == user!.uid?true:false,
        child: Container(
          padding:EdgeInsets.fromLTRB(0, 10, 10, 0),
          alignment: Alignment.topRight,
          child: IconButton(icon:Icon(Icons.clear,size:25,),onPressed: ()=>deletePostsDialog(context,postID,kind,PostImage)),
        ),
      ),
    ],
  );
}

final _FieldKey = GlobalKey<FormState>();

 commentsWidget(BuildContext context,String postId, String kind) async{

   TextEditingController commentFieldController = new TextEditingController();
   final commentField = Form(
       key: _FieldKey,
       child: TextFormField(
           controller: commentFieldController,
           keyboardType: TextInputType.name,
           validator: (value) {
             if (value!.isEmpty) {
               return ("u don't write Anything!");
             }
             return null;
           },
           onSaved: (value) {
             commentFieldController.text = value!;
           },
           textInputAction: TextInputAction.next,
           decoration: InputDecoration(
             prefixIcon: Icon(Icons.mode_comment,color:kind=='acc'?Colors.red:Colors.teal),
             contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
             hintText: "Write your Comment",
             
             border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(0),
             ),
           )

   ));


     Stream<QuerySnapshot<Map<String, dynamic>>> stream = await FirebaseFirestore.instance.collection('comments').orderBy('commentTime').snapshots();
    List CommentsList = await getCommetsList(postId,kind);
   return showDialog(useSafeArea: true,
       context: context, builder: (BuildContext context)
       {
         return StatefulBuilder(
             builder: (BuildContext context, StateSetter setState) {
           return AlertDialog(
             scrollable:true,
             content: Column(
               //mainAxisAlignment: MainAxisAlignment.center,
               //crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 SingleChildScrollView(
                   child: StreamBuilder(
                     stream: stream,
                     builder: (BuildContext context,
                         AsyncSnapshot<QuerySnapshot> snapshot) {
                       switch (snapshot.connectionState) {
                         case ConnectionState.waiting:
                           return new Center(child: new CircularProgressIndicator());
                         default:
                           return new Column(children: getExpenseItems(snapshot, context,postId,CommentsList,kind));
                       }
                     },),
                 ),
                 Container(
                   width: MediaQuery.of(context).size.width,
                   alignment:Alignment.bottomLeft,
                   padding:EdgeInsets.fromLTRB(0,20,0,0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Container(
                         width:MediaQuery.of(context).size.width/2.4,
                         child: commentField,
                       ),
                       SizedBox(width: 10,),
                       Container(
                         width:MediaQuery.of(context).size.width/6,
                         child: Material(
                           borderRadius: BorderRadius.all(Radius.circular(5.0)),
                           elevation: 0,
                           color: kind=='nor'?Colors.teal:Colors.red,
                           child: MaterialButton(
                               padding: EdgeInsets.all(5),
                               onPressed: () async {
                                 await addCommint(postId,commentFieldController.text,kind);
                                 setState((){
                                   commentFieldController.clear();
                                 });
                                 Navigator.of(context).pop();
                               },
                               child: Text(
                                 "Post",
                                 style: TextStyle(textBaseline:TextBaseline.alphabetic,fontSize: 20, color: Colors.white,fontWeight:FontWeight.bold),
                               )),
                         ),
                       ),
                     ],
                   ),
                 ),
               ],
             ),
           );
             });
       });

}

addCommint(String postid,String postContent, String kind) async{
   if(_FieldKey.currentState!.validate()){
     var collection ='posts';
     if (kind == 'nor'){
       collection = 'normalPosts';
     }
     //comment model call
     commentModel comment = commentModel();
     User? user = FirebaseAuth.instance.currentUser;
     comment.postId=postid;
     comment.commentContent=postContent;

     var snap= await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
     var ownerName =snap.get('firstName');
     comment.commentOwnerId =user.uid;
     comment.commentOwner=ownerName;
     final collRef = await FirebaseFirestore.instance.collection('comments');
     var docReference = collRef.doc();
     comment.commentId = docReference.id;
     docReference.set(comment.toMap());
     await FirebaseFirestore.instance.collection(collection).doc(postid).update({'comments': FieldValue.arrayUnion([comment.commentId])});
   }
}

  showComment(BuildContext context,String commentOwnerId,String Owner, String Content, Timestamp time,String postId,String commentId, String kind) {
    DateTime Date = time.toDate();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    String timeDate = dateFormat.format(Date);
    User? user = FirebaseAuth.instance.currentUser;

    return Container(
      width:MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Stack(
        children:
        [
          Visibility(
            visible:commentOwnerId == user!.uid?true:false,
            child: Container(
            alignment: Alignment.topRight,
            child: IconButton(icon:Icon(Icons.clear,size:15,),onPressed: ()=>deleteDialog(context,commentId,postId,kind)),
                     ),
          ),
          Container(padding:EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(Owner, style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: kind=='nor'?Colors.teal:Colors.red),
                  overflow: TextOverflow.clip,),
              ),
              Text(timeDate, style: TextStyle(fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.black38), overflow: TextOverflow.clip,),
              SizedBox(height: 2,),
              Text(Content, style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
                overflow: TextOverflow.clip,),
            ],
        ),
          ),],
      ),
    );
  }

getExpenseItems(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, BuildContext context,String postId,List commentList, String kind)  {
  List <Widget> commets =[];
    snapshot.data?.docs.forEach((element) {
      if (commentList.contains(element['commentId'])) {
        commets.add(showComment(context,element.get('commentOwnerId'),element.get('commentOwner'), element.get('commentContent'), element.get('commentTime'),element.get('postId'),element.get('commentId'),kind));
        print(commets);
      }
    });
    if(commets.isEmpty){
      commets.add(Container(padding: EdgeInsets.fromLTRB(5, 10, 5, 20),child: Text('No comments in this post yet',style: TextStyle(fontSize: 15,color: Colors.black38),),));
    }
  return commets;
}
Future getCommetsList(String postId, String kind)async{
   var collection='posts';
   if(kind =='nor'){
     collection = 'normalPosts';
   }
   var snap = await FirebaseFirestore.instance.collection(collection).doc(postId).get();
   return snap.get('comments');
}
deleteDialog(BuildContext context,String commentId,String postId, String kind){
  showDialog(context: context, builder: (BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 150,
        height: 150,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Are you want to delete this comment?',
              style: TextStyle(fontSize: 15, color: Colors.black38),),
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 0,
                  child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      onPressed: () {
                        deleteComments(context, commentId, postId,kind);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "yes",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )),
                ),
                SizedBox(width: 30),
                Material(
                  elevation: 0,
                  child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )),
                ),
              ],
            )

          ],
        ),
      ),
    );
  });
}

deleteComments(BuildContext context,String commentId,String postId, String kind) async{
   var collection ='posts';
   if (kind == 'nor'){
     collection = 'normalPosts';
   }
   await FirebaseFirestore.instance.collection(collection).doc(postId).update({'comments': FieldValue.arrayRemove([commentId])});
   await FirebaseFirestore.instance.collection('comments').doc(commentId).delete();
}

deletePostsDialog(BuildContext context ,String postId, String kind, String postImage){
  showDialog(context: context, builder: (BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 150,
        height: 150,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Are you want to delete this post?',
              style: TextStyle(fontSize: 15, color: Colors.black38),),
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 0,
                  child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      onPressed: () {
                        deletePost.deletePosts(context,postId,kind,postImage);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "yes",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )),
                ),
                SizedBox(width: 30),
                Material(
                  elevation: 0,
                  child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )),
                ),
              ],
            )

          ],
        ),
      ),
    );
  });
}