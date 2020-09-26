import 'dart:async';

import '_raw_validators.dart';

class ValidatorsMixin {
  final validatePhoneNumber = StreamTransformer<String, String>.fromHandlers(
    handleData: (phone, sink) {
      RawValidators.phoneValidator(
        phone,
        (error) => sink.addError(error),
        (success) => sink.add(success),
      );
    },
  );

  final validateAmount =
      StreamTransformer<int, int>.fromHandlers(handleData: (amount, sink) {
    if (amount != null && amount > 0) {
      sink.add(amount);
    } else {
      sink.addError("Invalid Amount");
    }
  });

  final validateUGXAmount =
      StreamTransformer<String, int>.fromHandlers(handleData: (amount, sink) {
        try {
          int amt =int.parse(amount);
          if (amt != null && amt >= 500) {
            sink.add(amt);
          } else {
            sink.addError("Amount can't be less than 500");
          }
        }catch(e){
          sink.addError("Invalid Amount $amount");
        }
  });
}
