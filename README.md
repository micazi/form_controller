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

```
  //* declare the controller.
  late FormController _formController;
  @override
  void initState() {
    super.initState();
      //* initialize the controller.
    _formController = FormController();
  }
  ...

  Form(
        //* Add form key from the controller.
        key: _formController.key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //* supply as many required controllers as needed from your one and only initialized controller,
            //* and give each one a unique id so you can retrieve the value later!
            const Text("field1"),
            TextFormField(
              controller: _formController.controller("val1"),
            ),
            const Text("field2"),
            TextFormField(
              controller: _formController.controller("val2"),
            ),

  ...

```

## ToDo list

[] Add Embedded form validations.

## Contributing

Contributing is more than welcomed on any of my packages/plugins.
I will try to keep adding suggested features as i go.

## Versioning

- **V0.1.0** - Initial Release.
- **V0.5.0** - Added Null Safety, resolved some issues, and added documentations.

## Authors

**Michael Aziz** - [Github](https://github.com/micazi)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details
