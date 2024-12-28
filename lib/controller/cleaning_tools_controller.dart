import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../modle/medicine.dart';

class CleaningToolsController extends GetxController {
  var medicines = <Medicine>[].obs;
  var isLoading = true.obs; 

  @override
  void onInit() {
    super.onInit();
    fetchMedicines();
  }

  Future<void> fetchMedicines() async {
    try {
      isLoading(true); 
      var snapshot = await FirebaseFirestore.instance
          .collection('medicines')
          .where('category', isEqualTo: 'للنظافة الشخصية والعناية بالبشرة')
          .get();
      
      medicines.value = snapshot.docs
          .map((doc) => Medicine.fromJson(doc.data()))
          .toList();
    } finally {
      isLoading(false);
    }
  }
}
