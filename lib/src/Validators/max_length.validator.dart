import 'form_controller_validator_base.dart';

class MaxLengthFormValidator extends FormControllerValidator {
  MaxLengthFormValidator(int length, {String? message})
      : super(
          name: 'minLength',
          message: message ?? "This field requires at most $length characters.",
          checks: (s) => (s != null && s != '')
              ? [
                  s.length <= length,
                ]
              : [false],
        );
}
