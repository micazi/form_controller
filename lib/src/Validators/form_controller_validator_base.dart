class FormControllerValidator {
  String name;
  String message;
  List<bool> Function(String? text) checks;
  //
  FormControllerValidator({
    required this.name,
    required this.message,
    required this.checks,
  });
  //
  bool checker(String? s) {
    List<bool> cks = checks(s);
    //
    return !cks.contains(false);
  }
}
