import 'package:rave_flutter/src/helpers/utils.dart';
import 'package:rave_flutter/src/models/momo_request.dart';
import 'package:rave_flutter/src/models/momo_response.dart';
export 'package:rave_flutter/src/models/momo_request.dart';
export 'package:rave_flutter/src/models/momo_response.dart';
import 'package:rave_flutter/src/resources/api.dart';

import '../../../rave_flutter.dart';

class UGMobileMoneyCore{
  Future<MoMoResponse> sendMoMoRequest(String secretKey,String phoneNumber,int amount,String email,String txRef,
      { String fullName,String redirectURL= "https://rave-webhook.herokuapp.com/receivepayment"}) async {


    if(secretKey == null || secretKey.trim().isEmpty){
      return Future.error("Secret Key Required.");
    }


    if(phoneNumber == null || phoneNumber.trim().isEmpty){
      return Future.error("Phone Number Required.");
    }

    if(amount == null || amount < 500){
      return Future.error("Amount can't be less than 500.");
    }

    if(email == null || email.trim().isEmpty){
      return Future.error("Email Required.");
    }

    if(txRef == null || txRef.trim().isEmpty){
      return Future.error("Transaction Reference Required.");
    }


    String network = Utils.provider(phoneNumber);

    if (network == null)
      return Future.error("Phone number doesn't match any network provider.");

    ApiProvider apiProvider = ApiProvider(secretKey);

    return apiProvider.sendMomoRequest(MoMoRequest.fromJson({
      "amount": amount,
      "phone_number": phoneNumber,
      "currency": 'UGX',
      "device_fingerprint": await RaveFlutter.deviceId,
      "tx_ref": txRef,
      "fullname": fullName ?? "",
      "network": network,
      "email": email,
      "redirect_url":redirectURL
    }));
  }
}