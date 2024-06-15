import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../viewmodel/controller/location_view/location_view_controller.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      init: LocationController(),
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              GoogleMap(
                onTap: (position) {
                  controller.customInfoWindowController.hideInfoWindow!();
                },
                onCameraMove: (position) {
                  controller.customInfoWindowController.onCameraMove!();
                },
                onMapCreated: (GoogleMapController mapController) async {
                  controller.customInfoWindowController.googleMapController = mapController;
                  controller.googleMapController = mapController;

                  // Move the camera to the user's location if available
                  if (controller.latLng != null) {
                    controller.googleMapController!.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(target: controller.latLng, zoom: controller.zoom),
                      ),
                    );
                  }
                },
                markers: controller.markers,
                polylines: controller.polylines,
                initialCameraPosition: CameraPosition(
                  target: controller.latLng,
                  zoom: controller.zoom,
                ),
              ),
              CustomInfoWindow(
                controller: controller.customInfoWindowController,
                height: 200,
                width: 300,
                offset: 35,
              ),
            ],
          ),
        );
      },
    );
  }
}
