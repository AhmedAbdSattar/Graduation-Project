class postModel {
  String? postId;
  String? postOwner;
  String? postOwnerId;
  String? postDescription;
  String? locationCity;
  String? locationTown;
  String? location;
  String? imageUrl;
  List <String> comments=[];
  DateTime postTime =DateTime.now();
  List<String> likes = [];

  postModel({this.postId,this.postOwnerId, this.postOwner, this.postDescription,this.locationTown,this.locationCity,this.location,this.imageUrl});

  // receiving data from server
  factory postModel.fromMap(map) {
    return postModel(
      postId: map['postId'],
      postOwnerId: map['postOwnerId'],
      postOwner: map['postOwner'],
      postDescription: map['postDescription'],
      locationTown: map['locationTown'],
      locationCity: map['locationCity'],
      location:map['location'],
      imageUrl: map['imageUrl'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'postOwnerId': postOwnerId,
      'postOwner': postOwner,
      'postDescription': postDescription,
      'locationTown': locationTown,
      'locationCity': locationCity,
      'location':location,
      'imageUrl': imageUrl,
      'comments': comments,
      'postTime': postTime,
      'likes':likes,
    };
  }
}
