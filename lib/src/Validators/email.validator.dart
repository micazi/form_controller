import 'form_controller_validator_base.dart';

class EmailFormValidator extends FormControllerValidator {
  EmailFormValidator({String? message})
      : super(
          name: 'email',
          message: message ?? 'Email is Invalid',
          checks: (s) => (s != null && s != '')
              ? [
                  RegExp(r'[\w-\.]+@([\w-]+\.)+[\w-]{2,6}').hasMatch(s),
                ]
              : [],
        );
}
