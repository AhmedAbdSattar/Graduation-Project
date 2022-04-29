class commentModel {
  String? commentId;
  String? postId;
  String? commentOwner;
  String? commentOwnerId;
  String? commentContent;
  DateTime commentTime =DateTime.now();

  commentModel({this.commentId, this.postId, this.commentOwner, this.commentContent,this.commentOwnerId});

  // receiving data from server
  factory commentModel.fromMap(map) {
    return commentModel(
      commentId: map['commentId'],
      postId: map['postId'],
      commentOwner: map['commentOwner'],
      commentContent: map['commentContent'],
      commentOwnerId: map['commentOwnerId'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'commentId': commentId,
      'postId': postId,
      'commentOwner': commentOwner,
      'commentContent': commentContent,
      'commentTime': commentTime,
      'commentOwnerId':commentOwnerId,
    };
  }
}
