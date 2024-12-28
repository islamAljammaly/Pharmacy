import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:pharmacy/modle/roshita.dart';
import '../modle/medicine.dart';
import '../modle/request.dart';
import '../modle/user.dart';
import '../service/service.dart';
import '../view/screen/auth/login_view.dart';

class UserController extends GetxController {
  var searchText = ''.obs;
  var requests = <Request>[].obs;
  var roshita = <Roshita>[].obs;
  Rx<File?> file = Rx<File?>(null);
  late String userId;
  var allMedicines = <Medicine>[].obs;
  var filteredMedicines = <Medicine>[].obs;
  final picker = ImagePicker();
  var isLoading = false.obs;
  Rxn<UserModel?> userModel = Rxn<UserModel?>();
  List<String> listType = ['طلبي لا يحتاج هذا السؤال', 'علبة', 'شريط'];
  List<RxString> selectedType = ['شريط'.obs, 'شريط'.obs, 'شريط'.obs, 'شريط'.obs, 'شريط'.obs];
  List<String> types = [];
  List<TextEditingController> quantity = [];
  late TextEditingController personName;
  late String email;
  late List<TextEditingController> name = [];
  late TextEditingController address;
  late TextEditingController number;
  List<String> listNumbers = ['1', '2', '3', '4', '5'];
  RxString numberRequests = '1'.obs;
  MyServices myServices = Get.find();

  @override
  void onInit() {
    email = myServices.sharedPreferences.getString("email")!;
    userId = myServices.sharedPreferences.getString("email")!;
    quantity = <TextEditingController>[];
    personName = TextEditingController();
    name = <TextEditingController>[];
    address = TextEditingController();
    number = TextEditingController();
    super.onInit();

    fetchRequests().listen((newRequests) {
      requests.value = newRequests;
    });
    fetchRoshita().listen((newRequests) {
      roshita.value = newRequests;
    });
  }

  Stream<List<Request>> fetchRequests() {
    return FirebaseFirestore.instance
        .collection('requests')
        .where('email', isEqualTo: email)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Request.fromJson(doc.data());
      }).toList();
    });
  }

  logOut() async {
    await FirebaseAuth.instance.signOut();
    Get.off(const LoginScreen());
  }

  Future<void> fetchMedicines() async {
    isLoading.value = true;
    var snapshot = await FirebaseFirestore.instance.collection('medicines').get();
    allMedicines.value = snapshot.docs
        .map((doc) => Medicine.fromJson(doc.data()))
        .toList();
    isLoading.value = false;
    filteredMedicines.value = allMedicines;
  }

  void filterMedicines(String query) {
    if (query.isEmpty) {
      filteredMedicines.value = [];
    } else {
      filteredMedicines.value = allMedicines
          .where((medicine) => medicine.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print('Picked File Path: ${pickedFile.path}');
    }
  }

  Future<void> sendRequest(
      List<String> medicineName,
      String address,
      List<String> quantity,
      String number,
      List<String> types,
      String email,
      String personName,
      RxString requestState) async {
    try {
      var request = Request(
        id: '',
        medicineName: medicineName,
        address: address,
        quantity: quantity,
        number: number,
        type: types,
        email: email,
        personName: personName,
        addedTime: DateTime.now(),
        initialRequestState: requestState.value,
      );

      var docRef = await FirebaseFirestore.instance.collection('requests').add(request.toJson());

      await docRef.update({'id': docRef.id});

      request.id = docRef.id;

      fetchRequests();
    } catch (e) {
      print('Error sending request: $e');
    }
  }

  Future<void> sendRoshita(File image, String address, String number, String email, String personName, RxString requestState) async {
    try {
      String imageUrl = await uploadImage(image);

      var roshita = Roshita(
        id: '',
        image: imageUrl,
        address: address,
        number: number,
        email: email,
        personName: personName,
        addedTime: DateTime.now(),
        initialRequestState: requestState.value,
      );

      var docRef = await FirebaseFirestore.instance.collection('roshita').add(roshita.toJson());

      await docRef.update({'id': docRef.id});

      roshita.id = docRef.id;

      fetchRoshita();
    } catch (e) {
      print('Error sending roshita: $e');
    }
  }

  Future<void> deleteMedicine(String id) async {
    await FirebaseFirestore.instance.collection('medicines').doc(id).delete();
  }

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file.value = File(image.path);
    }
  }

  Stream<List<Roshita>> fetchRoshita() {
    return FirebaseFirestore.instance
        .collection('roshita')
        .where('email', isEqualTo: email)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Roshita.fromJson(doc.data());
      }).toList();
    });
  }

  Future<String> uploadImage(File imageFile) async {
    try {
      String fileName = basename(imageFile.path);
      Reference ref = FirebaseStorage.instance.ref().child('roshita_images/$fileName');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  Future<void> deleteRequest(String requestId) async {
    try {
      await FirebaseFirestore.instance.collection('requests').doc(requestId).delete();
      requests.removeWhere((req) => req.id == requestId);
      print('Request $requestId deleted from Firestore');
    } catch (e) {
      print('Error deleting request: $e');
    }
  }

  Future<void> deleteRoshita(String roshitaId) async {
    try {
      await FirebaseFirestore.instance.collection('roshita').doc(roshitaId).delete();
      roshita.removeWhere((req) => req.id == roshitaId);
      print('Roshita $roshitaId deleted from Firestore');
    } catch (e) {
      print('Error deleting roshita: $e');
    }
  }

  @override
  void dispose() {
    address.dispose();
    number.dispose();
    personName.dispose();
    for (var controller in quantity) {
      controller.dispose();
    }
    for (var controller in name) {
      controller.dispose();
    }
    super.dispose();
  }
}
