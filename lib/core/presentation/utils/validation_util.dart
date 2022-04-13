import 'dart:core';

import 'package:easy_localization/easy_localization.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class Validation {

  static MultiValidator requiredValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'field_required_message'.tr()),
    ],
  );


  static MultiValidator passwordValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'field_required_message'.tr()),
      MinLengthValidator(8, errorText: 'password_verified_length_msg'.tr()),
      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
          errorText: 'password_verified_special_character_msg'.tr())
    ],
  );

  static MultiValidator emailValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'field_required_message'.tr()),
      EmailValidator(errorText: 'invalid_email_error_message'.tr()),
    ],
  );

  static bool validateAndSave(formKey) {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
