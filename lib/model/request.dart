import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Request {
  String? id;
  List<String>? medicineName;
  String? address;
  List<String>? quantity;
  String? number;
  List<String>? type;
  String? email;
  String? personName;
  DateTime? addedTime;
  RxString requestState;

  Request({
    this.id,
    this.medicineName,
    this.address,
    this.quantity,
    this.number,
    this.type,
    this.email,
    this.personName,
    this.addedTime,
    required String initialRequestState,
  }) : requestState = initialRequestState.obs;

  Request.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        medicineName = List<String>.from(json['medicineName'] ?? []),
        address = json['address'],
        quantity = List<String>.from(json['quantity'] ?? []),
        number = json['number'],
        type = List<String>.from(json['type'] ?? []),
        email = json['email'],
        personName = json['personName'],
        addedTime = json['addedTime'] is Timestamp
            ? (json['addedTime'] as Timestamp).toDate()
            : null,
        requestState = (json['requestState'] ?? 'قيد الانتظار').toString().obs;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicineName': medicineName,
      'address': address,
      'quantity': quantity,
      'number': number,
      'type': type,
      'email': email,
      'personName': personName,
      'addedTime': addedTime,
      'requestState': requestState.value,
    };
  }
}
