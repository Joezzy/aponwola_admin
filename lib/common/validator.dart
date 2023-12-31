import 'package:form_field_validator/form_field_validator.dart';

class Validator{

  var emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Enter a valid email address')
  ]);

  var passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 characters long'),
    PatternValidator(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
        errorText: 'should contain at least one upper case '
            '\nshould contain at least one lower case '
            '\nshould contain at least one digit '
            '\nAt least one Special character( ! @ # \$ & * ~ )')
  ]);

  var requiredValidator = RequiredValidator(errorText: 'This field is required');

}