import 'package:flutter/material.dart';


class NavbarModel {
  int currentRouteIndex;
  List<NavbarDataModel> items;

  NavbarModel({required this.currentRouteIndex, required this.items});

  NavbarModel copyWith({
    int? currentRouteIndex,
    List<NavbarDataModel>? items,
  }) {
    return NavbarModel(
      currentRouteIndex: currentRouteIndex ?? this.currentRouteIndex,
      items: items ?? this.items,
    );
  }
}

class NavbarDataModel {
  dynamic icon;
  String title;
  VoidCallback onTap;

  NavbarDataModel({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
