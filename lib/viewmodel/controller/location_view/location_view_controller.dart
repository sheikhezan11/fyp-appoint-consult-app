import 'dart:convert';
import 'dart:ui' as ui;
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationController extends GetxController {
  final CustomInfoWindowController customInfoWindowController = CustomInfoWindowController();
  LatLng latLng = const LatLng(24.8683, 67.0056); // Default location
  final double zoom = 15.0;
  final Set<Marker> markers = <Marker>{}.obs;
  final Set<Polyline> polylines = <Polyline>{}.obs; // Add this for polylines
  final Location location = Location();
  GoogleMapController? googleMapController;

  final List<String> images = [
    'assets/images/custompin.png',
    'assets/images/custompin.png',
  ];

  Uint8List? markerImage;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  @override
  void onInit() {
    super.onInit();
    _getUserLocation();
    loadData();
  }

  void _getUserLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData _locationData = await location.getLocation();
    latLng = LatLng(_locationData.latitude!, _locationData.longitude!);

    markers.add(
      Marker(
        markerId: const MarkerId('currentLocation'),
        position: latLng,
        infoWindow: const InfoWindow(
          title: 'Your Location',
        ),
      ),
    );

    update();

    // Animate the camera to the new location
    if (googleMapController != null) {
      googleMapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: zoom),
        ),
      );
    }

    // Fetch and display route to the nearest hospital
    fetchRouteToHospital();
  }

  void fetchRouteToHospital() async {
  LatLng hospitalLatLng = LatLng(24.8607, 67.0011);
  String apiKey = 'AIzaSyCg0uJGy4t94Mu7ngzUu6GjgmB2dsF9npo';
  String url =
      'https://maps.googleapis.com/maps/api/directions/json?origin=${latLng.latitude},${latLng.longitude}&destination=${hospitalLatLng.latitude},${hospitalLatLng.longitude}&key=$apiKey';

  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    if (json['routes'].isNotEmpty) {
      var route = json['routes'][0];
      var polylinePoints = route['overview_polyline']['points'];

      List<LatLng> points = _decodePolyline(polylinePoints);

      polylines.add(
        Polyline(
          polylineId: PolylineId('route1'),
          points: points,
          color: Colors.amber,
          width: 5,
        ),
      );

      update();
    }
  }
}


  List<LatLng> _decodePolyline(String polyline) {
    List<LatLng> points = [];
    int index = 0, len = polyline.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }

  void loadData() async {
    for (int i = 0; i < images.length; i++) {
      if (kDebugMode) {
        print('name${images[i]}');
      }
      final Uint8List markerIcon = await getBytesFromAsset(images[i].toString(), 100);

      markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: const LatLng(24.8607, 67.0011),
          icon: BitmapDescriptor.fromBytes(markerIcon),
          onTap: () {
            customInfoWindowController.addInfoWindow!(
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 300,
                      height: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://images.pexels.com/photos/1566837/pexels-photo-1566837.jpeg?cs=srgb&dl=pexels-narda-yescas-1566837.jpg&fm=jpg',
                          ),
                          fit: BoxFit.fitWidth,
                          filterQuality: FilterQuality.high,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.red,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              'Beef Tacos',
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                          ),
                          Spacer(),
                          Text('.3 mi.'),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Text(
                        'Help me finish these tacos! I got a platter from Costco and it’s too much.',
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const LatLng(24.8683, 67.0056),
            );
          },
        ),
      );

      update();
    }
  }
}
