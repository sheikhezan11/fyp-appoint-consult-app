class UserModel {
  String? uid;
  String? fullname;
  String? email;
  String? date;
  String? gender;
  String? profilepic;
  
  UserModel({this.uid, this.fullname, this.email, this.profilepic, });

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["fullname"];
    email = map["email"];
    date=map["date"];
    gender=map["gender"];
    profilepic = map["profilepic"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullname": fullname,
      "email": email,
      "date":date,
      "gender":gender,
      "profilepic": profilepic,
    };
  }

  @override
  String toString() {
    return 'UserModel{uid: $uid, fullname: $fullname, email: $email, date: $date, gender: $gender, profilepic: $profilepic}';
  }
}
