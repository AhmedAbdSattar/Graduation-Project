class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? phone;

  UserModel({this.uid, this.email, this.firstName, this.phone});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      phone: map['phone'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'phone': phone,
    };
  }
}
