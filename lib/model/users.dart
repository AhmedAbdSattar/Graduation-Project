class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? phone;
  String? deviceToken;
  UserModel({this.uid, this.email, this.firstName, this.phone,this.deviceToken});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      phone: map['phone'],
      deviceToken: map['deviceToken'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'phone': phone,
      'deviceToken': deviceToken,
    };
  }
}
