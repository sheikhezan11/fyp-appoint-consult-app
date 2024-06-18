import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/assets.dart';
import '../../resources/routes/pages.dart';
import '../../utils/custom_button.dart';
import '../../viewmodel/controller/doctor_detail/doctor_detail_controller.dart';

class DoctorDetail extends GetView<DoctorDetailController> {
  const DoctorDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                controller.detail!.doctorName.toString(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: Icon(
            //     Icons.favorite_border,
            //     color: Colors.black,
            //   ),
            // ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(2, 2),
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
                              image: NetworkImage(
                                  controller.detail!.profilepic.toString()),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.detail!.doctorName ?? "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 18),
                              ),
                              Text(
                                controller.detail!.doctorSpeciality ?? "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87),
                              ),
                              Text(controller.detail!.doctorAddress ?? ""),
                              const Row(
                                children: [
                                  Icon(Icons.star, color: Colors.orange),
                                  Text("4.9"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                            radius: 20,
                            child: const Icon(
                              Icons.people_alt_outlined,
                              size: 30,
                            ),
                          ),
                          const Column(
                            children: [
                              Text(
                                "100+",
                                style: TextStyle(
                                    fontSize: 9, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Patients",
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ]),
                        Column(children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                            radius: 20,
                            child: const Icon(
                              Icons.local_hospital_outlined,
                              size: 25,
                            ),
                          ),
                          const Column(
                            children: [
                              Text(
                                "5+",
                                style: TextStyle(
                                    fontSize: 9, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "'Experience",
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ]),
                        Column(children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                            radius: 20,
                            child: const Icon(
                              Icons.star,
                              size: 30,
                            ),
                          ),
                          const Column(
                            children: [
                              Text(
                                "4.5",
                                style: TextStyle(
                                    fontSize: 9, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Rating",
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ]),
                        Column(children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                            radius: 20,
                            child: const Icon(
                              Icons.message_outlined,
                              size: 25,
                            ),
                          ),
                          const Column(
                            children: [
                              Text(
                                "......",
                                style: TextStyle(
                                    fontSize: 9, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "'Reviews",
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ]),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "About me",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w600),
                        ),
                        Obx(
                          () => Text(
                            controller.detail!.aboutDoctor ?? "",
                            style: const TextStyle(fontSize: 15),
                            maxLines: controller.expanded.value ? null : 3,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        GestureDetector(
                            onTap: () {
                              controller.expanded.value =
                                  !controller.expanded.value;
                            },
                            child: Row(
                              children: [
                                Obx(
                                  () => Text(
                                    controller.expanded.value
                                        ? 'Show less'
                                        : 'Show more',
                                    style: const TextStyle(
                                        fontSize: 18, color: Color(0xff68609c)),
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Working Time",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w600),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: controller.detail!.workingTime != null
                                ? controller.detail!.workingTime!
                                    .map((time) => Text(time,
                                        style: const TextStyle(fontSize: 15)))
                                    .toList()
                                : const [],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Working Days",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w600),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: controller.detail!.workingDays != null
                                ? controller.detail!.workingDays!
                                    .map((day) => Text(day,
                                        style:
                                            const TextStyle(fontSize: 15)))
                                    .toList()
                                : const [],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Reviews",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "See All",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xff68609c)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(AssetsImages.saifee),
                              fit: BoxFit.cover,
                            )),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ezan Sheikh",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              Text(
                                "4.5",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry...."),
                    ],
                  ),
                ],
              ),
            ),
          ),
          FadeInUp(
              duration: const Duration(milliseconds: 1200),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 15.0),
                child: CustomButton(
                    clr: const Color(0xff68609c),
                    textClr: Colors.green,
                    buttonTitle: "Book Appointment",
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    ontapp: () {
                      Get.toNamed(Routes.bookAppointment,arguments: {
                        "doctorId":controller.doctorId,
                        "doctorDetail":controller.detail
                      });
                    }),
              )),
        ],
      ),
    );
  }
}
