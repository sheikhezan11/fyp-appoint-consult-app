import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../model/doctormodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryController extends GetxController {
  final RxString selectedCategory = 'All'.obs;
  final RxString searchQuery = ''.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<DoctorModel>> getDoctorsStream() {
    // Constructing the query based on selected category and search query
    Query query = _firestore.collection('doctors');
    if (selectedCategory.value != 'All') {
      query = query.where('doctorSpeciality', isEqualTo: selectedCategory.value);
    }
    if (searchQuery.value.isNotEmpty) {
      query = query.where('doctorName', isGreaterThanOrEqualTo: searchQuery.value);
    }

    if (kDebugMode) {
      print('Firestore Query: ${query.parameters}');
    } // Print query parameters for debugging

    return query.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => DoctorModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  void updateCategory(String category) {
    selectedCategory.value = category;
  }

  final List<String> categories = [
    'All',
    'Dentist',
    'Diabetes',
    'Cardiologist',
    'General',
    'Gastro-en',
    'Orthopedic',
  ];

  List<DoctorModel> getFilteredDoctors(List<DoctorModel> doctors) {
    // Apply filtering based on selected category and search query
    return doctors.where((doctor) {
      final bool isCategoryMatch =
          selectedCategory.value == 'All' || doctor.doctorSpeciality == selectedCategory.value;
      final bool isSearchMatch = searchQuery.value.isEmpty ||
          doctor.doctorName!.toLowerCase().contains(searchQuery.value.toLowerCase());
      return isCategoryMatch && isSearchMatch;
    }).toList();
  }

  // Define the getter for filteredDoctors
  List<DoctorModel> get filteredDoctors {
    final doctors = rxDoctors.value;
    // ignore: unnecessary_null_comparison
    if (doctors != null) {
      return getFilteredDoctors(doctors);
    }
    return [];
  }

  // Rx variable to hold the doctors data
  Rx<List<DoctorModel>> rxDoctors = Rx<List<DoctorModel>>([]);

  @override
  void onInit() {
    super.onInit();
    // Fetch doctors data from the stream and update rxDoctors
    getDoctorsStream().listen((List<DoctorModel> data) {
      rxDoctors.value = data;
      if (kDebugMode) {
        print('Doctors Data Updated: ${data.length} doctors retrieved');
      } // Print number of doctors retrieved for debugging
    });
  }
}
