import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Roshita {
  String? id;
  String? image;
  String? address;
  String? number;
  String? email;
  String? personName;
  DateTime? addedTime;
  RxString requestState;

  Roshita({
    this.id,
    this.image,
    this.address,
    this.number,
    this.email,
    this.personName,
    this.addedTime,
    required String initialRequestState,
  }) : requestState = initialRequestState.obs; 

  Roshita.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'],
        address = json['address'],
        number = json['number'],
        email = json['email'],
        personName = json['personName'],
        addedTime = json['addedTime'] is Timestamp
            ? (json['addedTime'] as Timestamp).toDate()
            : (json['addedTime'] is String
                ? DateTime.tryParse(json['addedTime'])
                : null),
        requestState = (json['requestState'] ?? 'قيد الانتظار').toString().obs;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'address': address,
      'number': number,
      'email': email,
      'personName': personName,
      'addedTime': addedTime,
      'requestState': requestState.value, 
    };
  }
}
