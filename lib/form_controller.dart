library form_controller;
import 'package:flutter/material.dart';

class FormController {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllerMap = {};
  TextEditingController controller(String name) {
    TextEditingController controller = TextEditingController();
    _controllerMap[name] = controller;
    return controller;
  }

  String text(String controller) {
    return _controllerMap[controller].text;
  }

  bool validate() {
    return key.currentState.validate();
  }
}
