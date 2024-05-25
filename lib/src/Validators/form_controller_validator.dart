import 'email.validator.dart';
import 'form_controller_validator_base.dart';
import 'is_required.validator.dart';
import 'max_length.validator.dart';
import 'min_length.validator.dart';
import 'numbers_only.validator.dart';

export './form_controller_validator_base.dart';
export './is_required.validator.dart';
export './email.validator.dart';
export './numbers_only.validator.dart';
export './min_length.validator.dart';
export './max_length.validator.dart';

class FormControllerValidators {
  //
  static FormControllerValidator isRequired({String? message}) => IsRequiredFormValidator(message: message);
  static FormControllerValidator email({String? message}) => EmailFormValidator(message: message);
  static FormControllerValidator numbersOnly({String? message}) => NumbersOnlyFormValidator(message: message);
  static FormControllerValidator minLength(int length, {String? message}) => MinLengthFormValidator(length, message: message);
  static FormControllerValidator maxLength(int length, {String? message}) => MaxLengthFormValidator(length, message: message);
  //
  static String? Function(String?)? validate(List<FormControllerValidator> validators) {
    return (validators.isNotEmpty)
        ? (s) {
            //
            Map<FormControllerValidator, bool> checks = {};
            //
            for (FormControllerValidator validator in validators) {
              bool res = validator.checker(s);
              checks.addEntries([MapEntry(validator, res)]);
            }
            //
            if (checks.containsValue(false)) {
              //s1 Has an Error!
              return checks.entries.where((e) => e.value == false).toList().first.key.message;
            } else {
              //s1 Has no Errors!
              return null;
            }
          }
        : null;
  }
}
