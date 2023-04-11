import 'dart:async';

import 'package:flutter/material.dart';

/// A controller to combine multible TextControllers and managing form satate.
///
///
/// {@tool snippet}
///
///
/// ```dart
/// class _ExampleState extends State<Example> {
///
///     late FormController _formController;
///
///   void initState() {
///     _formController = FormController();
///     super.initState();
///   }
///   Form(
///   key: _formController.key,
///   child: Column(

///     children: [
///       const Text("field1"),
///       TextFormField(
///         //* Initialize controllers using a unique id!
///         controller: _formController.controller("id1"),
///       ),
///       const Text("field2"),
///       TextFormField(
///         controller: _formController.controller("id2"),
///       ),
///       const Text("field3"),
///       TextFormField(
///         controller: _formController.controller("id3"),
///       ),
///       MaterialButton(
///         onPressed: () {
///           //* Get controller value
///           _formController.value("id1")
///           //* validate form
///           _formController.validate()
///           //* save form
///           _formController.save()
///           //* reset form
///           _formController.reset()
///         },
///       ),
///     ],
///   ),
/// ),
///
/// ```
/// {@end-tool}
class FormController {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _textControllers = {};
  FormController({
    this.controllers,
  }) {
    if (controllers != null) {
      for (var c in controllers!) {
        _textControllers.addEntries([MapEntry(c, TextEditingController())]);
      }
    }
  }

  ///
  /// Specify the controllers' ids to initialize at construction time.
  ///
  final List<String>? controllers;

  /// Use this key on the Form widget to get access to save,validate, and reset functions!
  ///
  /// {@tool snippet}
  ///
  ///
  /// ```dart
  /// class _ExampleState extends State<Example> {
  ///
  ///   Form(
  ///   key: _formController.key,
  ///   child:
  ///   ... )
  ///   ```
  /// {@end-tool}
  GlobalKey<FormState> get key => _formKey;

  /// Use this function to supply a text field with the required controller,make sure to use a unique id!
  ///
  ///
  /// {@tool snippet}
  /// ```dart
  ///       TextFormField(
  ///         controller: _formController.controller("id2"),
  ///       ),
  ///
  ///   ```
  /// {@end-tool}
  TextEditingController controller(String id, {String? initialText}) {
    late TextEditingController ret;
    if (_textControllers.containsKey(id) && _textControllers[id] != null) {
      ret = _textControllers[id]!;
    } else {
      TextEditingController newCon = TextEditingController(text: initialText);
      _textControllers.addEntries([MapEntry(id, newCon)]);
      ret = newCon;
    }
    return ret;
  }

  /// Use this function to get a text field value using the unique id you supplied earlier!
  ///
  ///
  /// {@tool snippet}
  /// ```dart
  ///         onPressed: () {
  ///           //* Get controller value
  ///           _formController.value("id1")
  /// }
  ///   ```
  /// {@end-tool}

  String value(String id) {
    late String ret;
    if (_textControllers.containsKey(id) && _textControllers[id] != null) {
      ret = _textControllers[id]!.text;
    } else {
      throw Exception(
          "No controllers found with the provided id, Did you create a controller with this id? Did you wait for the controller to initializ?");
    }
    return ret;
  }

  /// Use this function to stream a text field value using the unique id you supplied earlier!
  ///
  ///
  /// {@tool snippet}
  /// ```dart
  ///
  /// StreamBuilder<String>(
  ///   stream: _formController.valueStream("id1"),
  ///   builder: (context, snapshot) {
  ///     return Text("Stream of id1: ${snapshot.data}");
  ///   },
  /// ),
  ///
  ///   ```
  /// {@end-tool}
  Stream<String> valueStream(String id) {
    late Stream<String> _stream;
    if (_textControllers.containsKey(id) && _textControllers[id] != null) {
      StreamController<String> controller = StreamController();
      _stream = controller.stream;
      _textControllers[id]!.addListener(() {
        controller.add(_textControllers[id]!.text);
      });
    } else {
      throw Exception(
          "No controllers found with the provided id, Did you create a controller with this id? Did you wait for the controller to initializ?");
    }
    return _stream;
  }

  /// Use this function to set a text field value using the unique id you supplied earlier!
  ///
  ///
  /// {@tool snippet}
  /// ```dart
  ///         onPressed: () {
  ///           //* Set controller value
  ///           _formController.set("id1", "The new field value!")
  /// }
  ///   ```
  /// {@end-tool}
  void set(String id, String text) {
    if (_textControllers.containsKey(id) && _textControllers[id] != null) {
      _textControllers[id]!.text = text;
    } else {
      throw Exception(
          "No controllers found with the provided id, Did you create a controller with this id? Did you wait for the controller to initializ?");
    }
  }

  ///
  /// Validate the current form state.
  ///
  bool validate() {
    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    } else {
      throw Exception("Null Form Key State");
    }
  }

  ///
  /// Reset the current form state.
  ///
  void reset() {
    if (_formKey.currentState != null) {
      return _formKey.currentState!.reset();
    } else {
      throw Exception("Null Form Key State");
    }
  }

  ///
  /// Save the current form state.
  ///
  void save() {
    if (_formKey.currentState != null) {
      return _formKey.currentState!.save();
    } else {
      throw Exception("Null Form Key State");
    }
  }
}
