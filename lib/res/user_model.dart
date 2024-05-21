class UserModel {
  bool? canBook;
  String? slotsTime;
  int? doctorId;
  int? patientId;  
  UserModel(
      {this.canBook,
       this.slotsTime,
       this.doctorId,
       this.patientId,
     });

 UserModel.fromJson(Map<String, dynamic> json) {
    canBook = json['canBook'];
    slotsTime = json['slotsTime'];
    doctorId = json['doctorId'];
    patientId = json['patientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canBook'] = canBook;
    data['slotsTime'] = slotsTime;
     data['doctorId'] = doctorId;
      data['patientId'] = patientId;
    return data;
  }
}

