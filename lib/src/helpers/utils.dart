 import 'package:rave_flutter/src/helpers/regex.dart';

class Utils {
  static String provider(String phoneNumber){
    if(phoneNumber == null) return null;

    if(RegexHelper.mtnPhoneNumber.hasMatch(phoneNumber)) return "MTN";
    if(RegexHelper.airtelPhoneNumber.hasMatch(phoneNumber)) return "AIRTEL";
    if(RegexHelper.africellPhoneNumber.hasMatch(phoneNumber)) return "AFRICELL";
    return null;
  }

  static Function get mathFunc => (Match match) => '${match[1]},';
 }
