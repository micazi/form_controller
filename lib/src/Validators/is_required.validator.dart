import 'form_controller_validator_base.dart';

class IsRequiredFormValidator extends FormControllerValidator {
  IsRequiredFormValidator({String? message})
      : super(
          name: 'isRequired',
          message: message ?? 'This Field is Required',
          checks: (s) => [
            s != null,
            s!.isNotEmpty,
            s != '',
          ],
        );
}
