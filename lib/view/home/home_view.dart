import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import '../../resources/assets.dart';
import '../../resources/routes/pages.dart';
import '../../utils/categories_widget.dart';
import '../../utils/nearby_medical_centers.dart';
import '../../viewmodel/controller/dashboard/dashboard_controller.dart';
import '../../viewmodel/controller/home/home_controller.dart';
import '../category/categeory_view.dart';
import '../location/location_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController dashboardController =
        Get.put(DashboardController());
    return SafeArea(
        top: false,
        child: Scaffold(
          key: controller.scaffoldKey,
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                 const LocationView(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("location"),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined),
                                  SizedBox(width: 2),
                                  Text("Saddar, Karachi"),
                                  SizedBox(width: 3),
                                  Icon(Icons.keyboard_arrow_down_rounded),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.notifications_active_outlined,
                                    size: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              FutureBuilder(
                                  future: controller
                                      .fetchUserData(dashboardController.id),
                                  builder: (context, snapShot) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          // controller.openDrawer();
                                        },
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            dashboardController
                                                    .userModel?.profilepic ??
                                                "",
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 10.0),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.065,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            prefixIcon: const Icon(Icons.search),
                            labelText: 'Search doctors... ',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: CarouselSlider(
                      items: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 207, 141, 163),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'Looking for Best\n\t\t\t\t Doctors',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 19.5),
                                ),
                                Image.asset(
                                  AssetsImages.doc3,
                                  width: 70,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 184, 207, 247),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AssetsImages.doc2,
                                  width: 120,
                                ),
                                const Text(
                                  'Choose Best\n\t\t\t Doctors',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 73, 221, 150),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Easy Appointments',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Image.asset(
                                  AssetsImages.doc4,
                                  width: 70,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                        height: 170.0,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1000),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Categories',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const CategoryView(),
                              ),
                            );
                          },
                          child: const Text(
                            'See All',
                            style: TextStyle(
                              color: Color(0xff68609c),
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.category);
                              },
                              child: Categorycont(
                                clr: const Color(0xffDC9497),
                                imgg: AssetsImages.dentist,
                                textt: 'Dentistry',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const CategoryView(),
                                  ),
                                );
                              },
                              child: Categorycont(
                                clr: const Color(0xff93C19E),
                                imgg: AssetsImages.heart,
                                textt: 'Cardiology',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.category);
                              },
                              child: Categorycont(
                                clr: const Color(0xffF5AD7E),
                                imgg: AssetsImages.lungs,
                                textt: 'Pulmono..',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const CategoryView(),
                                  ),
                                );
                              },
                              child: Categorycont(
                                clr: const Color(0xffACA1CD),
                                imgg: AssetsImages.general,
                                textt: 'General',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.category);
                              },
                              child: Categorycont(
                                clr: const Color(0xff4D9B91),
                                imgg: AssetsImages.neuro,
                                textt: 'Neurology',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.category);
                              },
                              child: Categorycont(
                                clr: const Color(0xff352261),
                                imgg: AssetsImages.gast,
                                textt: 'Gastroen..',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.category);
                              },
                              child: Categorycont(
                                clr: const Color(0xffDEB6B5),
                                imgg: AssetsImages.labort,
                                textt: 'Laborato..',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.category);
                              },
                              child: Categorycont(
                                clr: const Color(0xff89CCDB),
                                imgg: AssetsImages.vaccine,
                                textt: 'Vaccinat..',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'NearBy Medical Centers',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                     const LocationView(),
                              ),
                            );
                          },
                          child: const Text(
                            'See All',
                            style: TextStyle(
                              color: Color(0xff68609c),
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            MedicalClinicCard(
                              imagePath: AssetsImages.aghakhan,
                              title: 'AghaKhan Hospital',
                            ),
                            MedicalClinicCard(
                              imagePath: AssetsImages.ziauddin,
                              title: 'Ziauddin Hospital',
                            ),
                            MedicalClinicCard(
                              imagePath: AssetsImages.saifee,
                              title: ' Saifee Hospital',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )));
          
}
}