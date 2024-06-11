import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/assets.dart';
import '../../resources/routes/pages.dart';
import '../../utils/categories_widget.dart';
import '../category/categeory_view.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Categories'),
      ),
      body:  Padding(
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
    );
    
  }
}
