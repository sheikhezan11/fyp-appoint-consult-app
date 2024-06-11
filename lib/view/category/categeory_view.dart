import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/routes/pages.dart';
import '../../viewmodel/controller/categories/categories_controller.dart';
import '../../viewmodel/controller/dashboard/dashboard_controller.dart';
import '../../viewmodel/controller/home/home_controller.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key,});

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.put(CategoryController());
    final DashboardController dashboardController =
        Get.put(DashboardController());
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Text(
                    "All Doctors",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                  ),
                  FutureBuilder(
                      future:
                          homeController.fetchUserData(dashboardController.id),
                      builder: (context, snapShot) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                dashboardController.userModel?.profilepic ??
                                    ""),
                          ),
                        );
                      }),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                height: 60.0,
                child: TextField(
                  onChanged: (value) {
                    controller.searchQuery.value = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    labelText: 'Search doctors...',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final category in controller.categories)
                    Obx(() => Padding(
                          padding: const EdgeInsets.only(left: 7.0),
                          child: CategoryButton(
                            categoryName: category,
                            onPressed: () =>
                                controller.updateCategory(category),
                            isSelected:
                                controller.selectedCategory.value == category,
                          ),
                        )),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Obx(() => Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "${controller.filteredDoctors.length} Result Found",
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.w500),
                  ),
                )),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() => ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemCount: controller.filteredDoctors.length,
                    itemBuilder: (context, index) {
                      final doctor = controller.filteredDoctors[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.doctorDetail, arguments: {
                            'doctorId': doctor.uid,
                            'detail': doctor
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey,
                                  image: DecorationImage(
                                    image: NetworkImage(doctor.profilepic ??
                                        'default_image_path'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          child: Text(
                                            doctor.doctorName ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 18),
                                          ),
                                        ),
                                        const Icon(Icons.favorite_border,
                                            color: Colors.black),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1,
                                    ),
                                    Text(
                                      doctor.doctorSpeciality ?? '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on_sharp),
                                        const SizedBox(
                                          width: 4.0,
                                        ),
                                        SizedBox(
                                          width: 180,
                                          child: Text(
                                            doctor.doctorAddress ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String categoryName;
  final VoidCallback onPressed;
  final bool isSelected;

  const CategoryButton({
    required this.categoryName,
    required this.onPressed,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          return isSelected ? const Color(0xff68609c) : Colors.white;
        }),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (states) => isSelected ? Colors.white : const Color(0xff68609c),
        ),
        side: MaterialStateProperty.resolveWith<BorderSide>(
          (states) => isSelected
              ? BorderSide.none
              : const BorderSide(color: Color(0xff68609c)),
        ),
      ),
      child: Text(
        categoryName,
        style: TextStyle(
          fontSize: 18,
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
