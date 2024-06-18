class BookAppointmentModel {
  String? uid;
  String? doctorName;
  String? doctorSpeciality;
  String? email;
  String? doctorTime;
  String? doctorDate;
  String? doctorAddress;
  String? profilePic;
  String? status;
  String? doctorUid;
  String? documentId;
  String? userName;
  String? userEmail;
  String? userProfilePic;

  BookAppointmentModel(
      {this.userEmail,
      this.userProfilePic,
      this.uid,
      this.doctorName,
      this.userName,
      this.doctorSpeciality,
      this.doctorAddress,
      this.email,
      this.doctorDate,
      this.doctorTime,
      this.profilePic,
      this.doctorUid,
      this.status,
      this.documentId});

  BookAppointmentModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    profilePic = map["profilePic"]; // Ensuring consistency in key names
    doctorName = map["doctorName"];
    email = map["email"];
    doctorSpeciality = map["doctorSpeciality"];
    doctorDate = map["appointmentDate"] as String?;
    doctorTime = map["workingTime"] as String?;
    doctorAddress = map["doctorAddress"];
    status = map["status"];
    doctorUid = map["doctorUid"];
    documentId = map["documentId"];
    userName = map["userName"];
    userEmail = map["userEmail"];
    userProfilePic = map["userProfile"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "doctorName": doctorName,
      "doctorSpeciality": doctorSpeciality,
      "email": email,
      "workingTime": doctorTime,
      "appointmentDate": doctorDate,
      "doctorAddress": doctorAddress,
      "profilePic": profilePic,
      "status": status,
      "doctorUid": doctorUid,
      "documentId": documentId,
      "userEmail":userEmail,
      "userName": userName,
      "userProfile":userProfilePic
    };
  }
}
