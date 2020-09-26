import 'package:rave_flutter/src/helpers/regex.dart';

class RawValidators{
  static void phoneValidator(String phone, Function(dynamic error) onError,
      Function(dynamic data) onSuccess) {
    if (phone == null || phone.trim().isEmpty) {
      onError("Phone required.");
    } else if (!RegexHelper.phoneNumber.hasMatch(phone)) {
      onError("Invalid phone e.g 0705000111");
    }  else {
      onSuccess(phone);
    }
  }
}