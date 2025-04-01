import 'dart:async';

import 'package:flutter/material.dart';
import '../infrastructure/list.extensions.dart';

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
  final Map<String, GlobalKey<FormFieldState>> _controllersStateKeys = {};
  final Map<String, bool> _obscurity = {};
  final Map<String, StreamController<String>> _streamControllers = {};
  FormController(
    this._initialValues,
  ) {
    if (_initialValues != null) {
      for (var c in _initialValues!.keys) {
        _textControllers.addEntries([MapEntry(c, TextEditingController(text: _initialValues![c]!.$1))]);
        _controllersStateKeys.addEntries([MapEntry(c, GlobalKey<FormFieldState>(debugLabel: c))]);
        _obscurity.addEntries([MapEntry(c, _initialValues![c]!.$2)]);
      }
    }
  }

  ///
  /// Specify the controllers' initial obscurity state and value to initialize at construction time.
  ///
  final Map<String, (String initialText, bool initialObscurity)>? _initialValues;

  ///
  /// Get access to all currently saved controllers with their current values.
  ///
  Map<String, String> get controllers => Map.fromEntries(_textControllers.entries.map((c) => MapEntry(c.key, c.value.text)).toList());

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

  /// Use this key on the TextFormField widget to get access to validateOnly function!
  ///
  /// {@tool snippet}
  ///
  ///
  /// ```dart
  /// class _ExampleState extends State<Example> {
  ///
  ///   TextFormField(
  ///   key: _formController.fieldStateKey('fieldId'),
  ///   ... )
  ///   ```
  /// {@end-tool}
  GlobalKey<FormFieldState>? fieldStateKey(String fieldID) => _controllersStateKeys[fieldID];

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
  TextEditingController controller(String id, {String? initialText, bool isObscure = false}) {
    late TextEditingController ret;
    if (_textControllers.containsKey(id) && _textControllers[id] != null) {
      ret = _textControllers[id]!;
    } else {
      TextEditingController newCon = TextEditingController(text: initialText);
      _textControllers.addEntries([MapEntry(id, newCon)]);
      _controllersStateKeys.addEntries([MapEntry(id, GlobalKey<FormFieldState>(debugLabel: id))]);
      _obscurity.addEntries([MapEntry(id, isObscure)]);
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
      _throwControllerNotFound(id);
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
    late Stream<String> stream;
    if (_textControllers.containsKey(id) && _textControllers[id] != null) {
      _streamControllers.addEntries([MapEntry(id, StreamController())]);
      // ignore: close_sinks
      StreamController<String> c = _streamControllers[id]!;
      stream = c.stream;
      _textControllers[id]!.addListener(() {
        c.add(_textControllers[id]!.text);
      });
    } else {
      _throwControllerNotFound(id);
    }
    return stream;
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
      _throwControllerNotFound(id);
    }
  }

  /// Use this function to get controller's obscurity value using the unique id you supplied earlier!
  ///
  ///
  /// {@tool snippet}
  /// ```dart
  ///         onPressed: () {
  ///           //* Get obscurity value
  ///           _formController.isObscure("id1")
  /// }
  ///   ```
  /// {@end-tool}

  bool isObscure(String id) {
    late bool ret;
    if (_textControllers.containsKey(id) && _textControllers[id] != null) {
      ret = _obscurity[id]!;
    } else {
      _throwControllerNotFound(id);
    }
    return ret;
  }

  /// Use this function to set controller's obscurity value using the unique id you supplied earlier!
  ///
  ///
  /// {@tool snippet}
  /// ```dart
  ///         onPressed: () {
  ///           //* Set controller obscurity value
  ///           _formController.setsetObscurity("id1", true)
  /// }
  ///   ```
  /// {@end-tool}
  void setObscurity(String id, bool isObscure) {
    if (_textControllers.containsKey(id) && _textControllers[id] != null) {
      _obscurity[id] = isObscure;
    } else {
      _throwControllerNotFound(id);
    }
  }

  /// Use this function to toggle controller's obscurity status using the unique id you supplied earlier!
  ///
  ///
  /// {@tool snippet}
  /// ```dart
  ///         onPressed: () {
  ///           //* Toggle controller obscurity value
  ///           _formController.toggleObscurity("id1")
  /// }
  ///   ```
  /// {@end-tool}
  void toggleObscurity(String id) {
    if (_textControllers.containsKey(id) && _textControllers[id] != null) {
      _obscurity[id] = !_obscurity[id]!;
    } else {
      _throwControllerNotFound(id);
    }
  }

  ///
  /// Validate the current form state.
  ///
  bool validate() {
    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    } else {
      throw Exception("");
    }
  }

  ///
  /// Validates the desired fields only.
  ///
  bool validateOnly(List<String> fieldIDs) {
    List<bool> validReturns = [];
    if (_textControllers.isNotEmpty && _textControllers.keys.toList().containsAll(fieldIDs) && _controllersStateKeys.keys.toList().containsAll(fieldIDs)) {
      for (var f in fieldIDs) {
        if (_controllersStateKeys[f] != null && _controllersStateKeys[f]!.currentState != null) {
          validReturns.add(_controllersStateKeys[f]!.currentState!.validate());
        }
      }
    } else {
      throw Exception("field IDs do not exist.");
    }
    return !validReturns.contains(false);
  }

  ///
  /// Submit the current form (Validate and return values).
  ///
  void submit({List<bool> Function(Map<String, String>)? extraValidators, Function(Map<String, String> values)? onSuccess}) {
    Map<String, String> r = {};
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _textControllers.forEach((key, value) {
          r.addEntries([MapEntry(key, value.text)]);
        });
        if (extraValidators == null || !extraValidators(r).contains(false)) {
          if (onSuccess != null) onSuccess(r);
        }
      }
    } else {
      _throwFormKeyNullState();
    }
  }

  ///
  /// Reset the current form state.
  ///
  void reset() {
    if (_formKey.currentState != null) {
      return _formKey.currentState!.reset();
    } else {
      _throwFormKeyNullState();
    }
  }

  ///
  /// Save the current form state.
  ///
  void save() {
    if (_formKey.currentState != null) {
      return _formKey.currentState!.save();
    } else {
      _throwFormKeyNullState();
    }
  }

  ///
  /// Dispose of all StreamControllers.
  ///
  Future<void> dispose() async {
    _streamControllers.forEach((key, value) async {
      await value.close();
    });
  }

  void _throwControllerNotFound(String id) =>
      throw Exception("No controllers found with the provided id `$id`, Did you create a controller with this id? Did you wait for the controller to initializ?");

  void _throwFormKeyNullState() => throw Exception("The form key is unmounted, Did you forget to add it to the Form widget?");
}
