import 'form_controller_validator_base.dart';

class MinLengthFormValidator extends FormControllerValidator {
  MinLengthFormValidator(int length, {String? message})
      : super(
          name: 'minLength',
          message: message ?? "This field requires at least $length characters.",
          checks: (s) => (s != null && s != '')
              ? [
                  s.length >= length,
                ]
              : [false],
        );
}
