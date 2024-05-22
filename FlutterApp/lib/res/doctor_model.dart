import 'dart:convert';

import 'package:hospital/res/app_api.dart';
import 'package:http/http.dart' as http;

class UserService {
  var url = Uri.https(AppApi.baseUrl, AppApi.doctor);
  List<DoctorModel>? userProfile;
  Future<List<DoctorModel>?> getData() async {
    List<DoctorModel>? userModel;
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      try {
        userModel = (json.decode(response.body) as List)
            .map((data) => DoctorModel.fromJson(data))
            .toList();
        userProfile = userModel;
      } catch (e) {
        print(e);
      }
    } else if (response.statusCode == 403 || response.statusCode == 401) {}
    return userModel;
  }
}

class DoctorAppointment {
  String getRecord = "Appointment/doctor/2";
  List<DoctorAppointmentModel>? doctorProfile;
  Future<List<DoctorAppointmentModel>?> getData() async {
    var url = Uri.https(AppApi.baseUrl, getRecord);
    List<DoctorAppointmentModel>? userModel;
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      try {
        userModel = (json.decode(response.body) as List)
            .map((data) => DoctorAppointmentModel.fromJson(data))
            .toList();
        doctorProfile = userModel;
      } catch (e) {
        print(e);
      }
    } else if (response.statusCode == 403 || response.statusCode == 401) {}
    return userModel;
  }
}

class DoctorModel {
  int? id;
  String? firstName;
  String? lastName;
  String? specialization;
  DoctorModel({
    this.id,
    this.firstName,
    this.lastName,
    this.specialization,
  });

  DoctorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstname'];
    lastName = json['lastname'];
    specialization = json['specialization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['lastName'] = lastName;
    data['lastName'] = lastName;
    data['specialization'] = specialization;
    return data;
  }
}

class DoctorAppointmentModel {
  int? doctorId;
  int? patientId;
  String? appointmentDate;
  String? date;
  String? time;
  DoctorAppointmentModel({
    this.doctorId,
    this.patientId,
    this.appointmentDate,
    this.date,
    this.time
  });
  DoctorAppointmentModel.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctorId'];
    patientId = json['patientId'];
    appointmentDate = json['appointmentDate'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorId'] = doctorId;
    data['patientId'] = patientId;
    data['appointmentDate'] = appointmentDate;
    data['date'] = date;
    data['time'] = time;
    return data;
  }
}
