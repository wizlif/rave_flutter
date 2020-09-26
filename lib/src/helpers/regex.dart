//
// A Regular Expression Helper
//
// Use this helper to handle regex related functionalities like
// validation.
//
// The regex are in form of [RegExp] [static] getters
//
// ```
//   static void phoneValidator(String phone, Function(dynamic error) onError,
//    Function(dynamic data) onSuccess) {
//    if (phone == null || phone.trim().isEmpty) {
//      onError("Phone required.");
//    } else if (!RegexHelper.phoneNumber.hasMatch(phone)) {
//      onError("Invalid phone e.g 0705000111");
//    }  else {
//      onSuccess(phone);
//    }
//    }
//    ```
//
class RegexHelper{
  // Validate a phone number as Airtel, MTN or Africell
  static RegExp get phoneNumber => RegExp(r'''^(07[05789][0-9]{7})|(2567[05789][0-9]{7})$''');

  // Validate an Airtel number i.e 070, 075, 25670 or 25675
  static RegExp get airtelPhoneNumber => RegExp(r'''^(07[05][0-9]{7})|(2567[05][0-9]{7})$''');

  // Validate MTN number i.e 078, 077, 25678 or 25677
  static RegExp get mtnPhoneNumber => RegExp(r'''^(07[78][0-9]{7})|(2567[78][0-9]{7})$''');

  // Validate Africell number i.e 079 or 25679
  static RegExp get africellPhoneNumber => RegExp(r'''^(079[0-9]{7})|(25679[0-9]{7})$''');

  // Money formatting to comma separated numbers
  static RegExp get reg => new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
}