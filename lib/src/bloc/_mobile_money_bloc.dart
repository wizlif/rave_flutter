import 'package:dash/dash.dart';
import 'package:rave_flutter/rave_flutter.dart';
import 'package:rave_flutter/src/helpers/utils.dart';
import 'package:rave_flutter/src/mixins/validators.dart';
import 'package:rave_flutter/src/models/momo_request.dart';
import 'package:rave_flutter/src/models/momo_response.dart';
import 'package:rave_flutter/src/resources/api.dart';
import 'package:rxdart/rxdart.dart';

class MobileMoneyBloc with ValidatorsMixin implements Bloc {
  // Amount
  BehaviorSubject<String> _amount = BehaviorSubject<String>();

  Stream<int> get amount => _amount.stream.transform(validateUGXAmount);

  Function(String) get changeAmount => _amount.sink.add;

  // Phone Number
  BehaviorSubject<String> _phone = BehaviorSubject<String>();

  Stream<String> get phone => _phone.stream.transform(validatePhoneNumber);

  Function(String) get changePhone => _phone.sink.add;

  Stream<bool> get isInputInValid =>
      Rx.combineLatest2(amount, phone, (e, p) => true);

  final _error = BehaviorSubject<String>();

  Stream<String> get error => _error.stream;

  Function(String) get setError => _error.sink.add;


  // Initialize MM Request
  Future<MoMoResponse> sendMoMoRequest(String secretKey,int amount,String email,String transactionId,
      { String fullName, String redirectURL}) async {
    String network = Utils.provider(_phone.value);

    if (network == null)
      return Future.error("Phone number doesn't match any network provider.");

    ApiProvider apiProvider = ApiProvider(secretKey);

    return apiProvider.sendMomoRequest(MoMoRequest.fromJson({
      "amount": _amount.value,
      "phone_number": _phone.value,
      "currency": 'UGX',
      "device_fingerprint": await RaveFlutter.deviceId,
      "tx_ref": transactionId,
      "fullname": fullName ?? "",
      "network": network,
      "email": email,
      "redirect_url": redirectURL
    }));
  }

  reset(){
    _phone.close();
    setError(null);

    _phone = BehaviorSubject<String>();
  }

  @override
  dispose() {
    _amount.close();
    _phone.close();
    _error.close();
  }

  static Bloc instance() => MobileMoneyBloc();
}
