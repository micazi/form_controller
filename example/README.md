```dart
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
    _formController = FormController(controllers: ['val1', 'val2', 'val3']);
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
              //* Add Initial Text for Controllers. [Ignored if pre-initialized in the constructor]
              controller: _formController.controller("val3", initialText: "Initial Text!"),
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
            MaterialButton(
                onPressed: () {
            //* Set controllers' values programatically!
                  _formController.set('val2', "This is the new text!");
                },
                child: const Text("Set V2 data!"),
              ),
            //* Access a controller's value as a stream!
            StreamBuilder<String>(
                stream: _formController.valueStream("val1"),
                builder: (context, snapshot) {
                  return Text("Stream of V1: ${snapshot.data}");
                },
              ),
            //* Control the obscurity status of a field with ease!
            Row(
              children:[
            TextFormField(
              //* Add Initial Obscurity Status for Controllers.
              controller: _formController.controller("val4", isObscure:true),
            ),
            MaterialButton(
                onPressed: () {
                  //* Toggle controllers' obscurity programatically with ease!!
                  _formController.toggleObscurity('val4');
                },
                child: Icon(Icons.eye),
              ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}

//* Use the dispose method to close all streaming controllers after usage!
  @override
  void dispose() async {
    await _formController.dispose();
    super.dispose();
  }

```
