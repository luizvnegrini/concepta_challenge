import 'package:flutter/material.dart';

import '../../service_locator.dart';

abstract class BasePage<TWidget extends StatefulWidget,
    TController extends ValueNotifier<dynamic>> extends State<TWidget> {
  final controller = ServiceLocator.getInstance<TController>();
}