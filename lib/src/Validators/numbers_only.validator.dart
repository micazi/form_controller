import 'form_controller_validator_base.dart';

class NumbersOnlyFormValidator extends FormControllerValidator {
  NumbersOnlyFormValidator({String? message})
      : super(
          name: 'numbersOnly',
          message: message ?? "Only numbers are allowed",
          checks: (s) => (s != null && s != '')
              ? [
                  RegExp(r'[0-9]').hasMatch(s),
                ]
              : [],
        );
}
