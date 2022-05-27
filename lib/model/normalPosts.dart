class normalpostModel {
  String? postId;
  String? postOwner;
  String? postOwnerId;
  String? postDescription;
  String? locationCity;
  String? locationTown;
  String? location;
  String? imageUrl;
  String? kind = 'nor';
  List <String> comments=[];
  DateTime postTime =DateTime.now();
  List<String> likes = [];

  normalpostModel({this.postId,this.postOwnerId, this.postOwner, this.postDescription,this.locationTown,this.locationCity,this.location,this.imageUrl,this.kind});

  // receiving data from server
  factory normalpostModel.fromMap(map) {
    return normalpostModel(
      postId: map['postId'],
      postOwnerId: map['postOwnerId'],
      postOwner: map['postOwner'],
      postDescription: map['postDescription'],
      locationTown: map['locationTown'],
      locationCity: map['locationCity'],
      location:map['location'],
      imageUrl: map['imageUrl'],
      kind: map['kind'],
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
      'kind':'nor'
    };
  }
}
