# form_controller

A controller to combine multible TextControllers and managing form satate.

## Getting Started

### 1. Depend on it

Add this to your package's pubspec.yaml file:

```
dependencies:
  form_controller: [latest version]
```

### 2. Install it

```
$ flutter pub get
```

### 3. Import it

```
import 'package:form_controller/form_controller.dart';
```

## Example

```dart
  //* declare the controller.
  late FormController _formController;
  @override
  void initState() {
    super.initState();
      //* initialize the controller.
    _formController = FormController();
  }
  ..dart

 Form(
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
          ],
        ),
      ),

  //* Use the dispose method to close all streaming controllers after usage!
  @override
  void dispose() async {
    await _formController.dispose();
    super.dispose();
  }

```

## ToDo list

[x] Add initial text.
[x] Add Text setters.
[x] Add text value stream.
[] Add Embedded form validations.

## Contributing

Contributing is more than welcomed on any of my packages/plugins.
I will try to keep adding suggested features as i go.

## Versioning

- **V0.1.0** - Initial Release.
- **V0.5.0** - Added Null Safety, resolved some issues, and added documentations.
- **V0.8.2** - Added Controller's initial text, text value stream, and text setters.

## Authors

**Michael Aziz** - [Github](https://github.com/micazi)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details
