class DoctorModel {
  String? uid;
  String? doctorName;
  String? doctorSpeciality;

  String? aboutDoctor;
  List<String>? workingTime; // Changed to List<String>
  List<String>? workingDays; // Changed to List<String>
  String? doctorAddress;
  String? profilepic;
  bool? isFavorite;
  String? doctorUid;
  String? email;

  DoctorModel({
    this.uid,
    this.doctorName,
    this.doctorSpeciality,
    this.doctorAddress,
    this.aboutDoctor,
    this.email,
    this.workingTime,
    this.workingDays,
    this.doctorUid,
    this.profilepic,
    this.isFavorite = false,
  });

  DoctorModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    profilepic = map["profilepic"];
    doctorName = map["doctorName"];
    email = map["email"];

    doctorSpeciality = map["doctorSpeciality"];
    aboutDoctor = map["aboutDoctor"];
    workingTime = (map["workingTime"] as String?)
        ?.split(','); // Split the string into a list
    workingDays = (map["workingDays"] as String?)
        ?.split(','); // Split the string into a list
    doctorAddress = map["doctorAddress"];
    isFavorite = map["isFavorite"];
    doctorUid = map["doctorUid"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "doctorName": doctorName,
      "doctorSpeciality": doctorSpeciality,
      "email": email,
      "aboutDoctor": aboutDoctor,
      "workingTime": workingTime?.join(','), // Join the list into a string
      "workingDays": workingDays?.join(','), // Join the list into a string
      "doctorAddress": doctorAddress,
      "profilepic": profilepic,
      "isFavorite": isFavorite,
      "doctorUid": doctorUid
    };
  }

  static fromJson(doctorModArg) {}
}
