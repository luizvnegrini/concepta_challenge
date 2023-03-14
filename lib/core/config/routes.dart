import 'package:flutter/material.dart';

import '../../presentation/presentation.dart';

class Routes {
  static String get home => '/home';
  static String get packageDetails => '/details';
}

List<MapEntry<String, Widget Function(BuildContext)>> routes = [
  MapEntry(
    Routes.home,
    (context) => const MainPage(),
  ),
  MapEntry(
    Routes.packageDetails,
    (context) => const PackageDetailsPage(),
  ),
];
