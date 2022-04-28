

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/Commets.dart';
import 'package:intl/intl.dart';

 Widget showPost(BuildContext context,String postID,String postOwner,String PostDescription,String PostImage,String postLocation,Timestamp postDate,List<dynamic> likesList,List commentsList){
  DateTime Date = postDate.toDate();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
  String time =dateFormat.format(Date);
  
  User? user = FirebaseAuth.instance.currentUser;
  bool? isliked;

  return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
    margin: EdgeInsets.all(20),
    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 1.0),
    ],color: Colors.white),
    width: MediaQuery.of(context).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //name
        Text(postOwner,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.teal),overflow: TextOverflow.clip,),
        //time
        Text(postLocation+'  '+'$time',style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,color:Colors.black54),overflow: TextOverflow.clip,),
        //Image
        SizedBox(height: 5,),
        Center(child: Image.network(PostImage,fit:BoxFit.cover,)),
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
                         FirebaseFirestore.instance.collection('posts').doc(postID).update({'likes': FieldValue.arrayRemove([user.uid])});
                      });
                    }else{
                      setState(() {
                        isliked =true;
                         FirebaseFirestore.instance.collection('posts').doc(postID).update({'likes': FieldValue.arrayUnion([user.uid])});
                      });
                    }
                  },
                  icon: likesList.contains(user!.uid)?Icon(Icons.star,color:Colors.orange,size:30,):Icon(Icons.star_border_outlined,color:Colors.black,size: 30,)),
              Text('${likesList.length} Stars',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight:FontWeight.bold ),), SizedBox(width: 5,),
              //Comments Icon
              IconButton(onPressed: ()=>commentsWidget(context, postID), icon: Icon(Icons.comment,color: Colors.black,))
            ],
          ),
        ),
        //description
        Text(PostDescription,style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color:Colors.black),overflow: TextOverflow.clip,),

      ],
    ),

  );
      }
   );
}

final _FieldKey = GlobalKey<FormState>();

 commentsWidget(BuildContext context,String postId) async{

   TextEditingController commentFieldController = new TextEditingController();
   final commentField = Form(
       key: _FieldKey,
       child: TextFormField(
           autofocus: false,
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
             prefixIcon: Icon(Icons.mode_comment),
             contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
             hintText: "Write your Comment",
             border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(0),
             ),
           )

   ));


     Stream<QuerySnapshot<Map<String, dynamic>>> stream = await FirebaseFirestore.instance.collection('comments').orderBy('commentTime').snapshots();
    List CommentsList = await getCommetsList(postId);
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
                           return new Column(children: getExpenseItems(snapshot, context,postId,CommentsList));
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
                           color: Colors.teal,
                           child: MaterialButton(
                               padding: EdgeInsets.all(5),
                               onPressed: () async {
                                 await addCommint(postId,commentFieldController.text);
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

addCommint(String postid,String postContent) async{
   if(_FieldKey.currentState!.validate()){

     //comment model call
     commentModel comment = commentModel();
     User? user = FirebaseAuth.instance.currentUser;
     comment.postId=postid;
     comment.commentContent=postContent;

     var snap= await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
     var ownerName =snap.get('firstName');

     comment.commentOwner=ownerName;
     final collRef = await FirebaseFirestore.instance.collection('comments');
     var docReference = collRef.doc();
     comment.commentId = docReference.id;
     docReference.set(comment.toMap());
     await FirebaseFirestore.instance.collection('posts').doc(postid).update({'comments': FieldValue.arrayUnion([comment.commentId])});
   }
}

  showComment(String Owner, String Content, Timestamp time) {
    DateTime Date = time.toDate();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    String timeDate = dateFormat.format(Date);

    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Owner, style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
            overflow: TextOverflow.clip,),
          Text(timeDate, style: TextStyle(fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Colors.black38), overflow: TextOverflow.clip,),
          SizedBox(height: 2,),
          Text(Content, style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
            overflow: TextOverflow.clip,),

        ],
      ),
    );
  }

getExpenseItems(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, BuildContext context,String postId,List commentList)  {
  List <Widget> commets =[];
    snapshot.data?.docs.forEach((element) {
      if (commentList.contains(element['commentId'])) {
        commets.add(showComment(element.get('commentOwner'), element.get('commentContent'), element.get('commentTime')));
        print(commets);
      }
    });
  return commets;
}
Future getCommetsList(String postId)async{
   var snap = await FirebaseFirestore.instance.collection('posts').doc(postId).get();
   return snap.get('comments');
}

