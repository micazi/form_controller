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
  // declare
  FormController _controller;

  void initState() {
    // initialize
    _controller = FormController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          // Add the key to your form.
          key: _controller.key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                // Add a controller to each field and give it a string key name. e.g 'username'
                controller: _controller.controller("username"),
              ),
              TextFormField(
                controller: _controller.controller("password"),

              ),
              RaisedButton(
                child: Text("Do something!"),
                onPressed: () {
                  // check if form fields are validated
                  if (_controller.validate()) {
                    // get text from coontrollers by simply controller.text('key name').
                    debugPrint(
                        "username: ${_controller.text('username')} , pass: ${_controller.text('password')}");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```
