```
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:form_controller/form_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FormController Demo',
      home: Example(),
    );
  }
}

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  //* declare the controller.
  late FormController _formController;
  @override
  void initState() {
    super.initState();
      //* initialize the controller.
    _formController = FormController();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Form(
        //* Add form key from the controller.
        key: _formController.key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //* supply as many required controllers as needed from your one and only initialized controller,
            //* and give each one a unique id so you can retrieve the value later!
            //*
            const Text("field1"),
            TextFormField(
              controller: _formController.controller("val1"),
            ),
            const Text("field2"),
            TextFormField(
              controller: _formController.controller("val2"),
            ),
            const Text("field3"),
            TextFormField(
              controller: _formController.controller("val3"),
            ),
            MaterialButton(
            //* Retrieve the controller values easily with the id.
              onPressed: () {
                debugPrint(
                  "Con1: " + _formController.value("val1"),
                );
                debugPrint(
                  "Con2: " + _formController.value("val2"),
                );
                debugPrint(
                  "Con3: " + _formController.value("val3"),
                );
            //* Get access to form state functions such as validate,reset, and save!
                _formController.reset();
                _formController.validate();
                _formController.save();
              },
              child: const Text("Get data!"),
            ),
          ],
        ),
      ),
    );
  }
}

```
