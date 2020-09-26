import 'package:rave_flutter/src/models/momo_request.dart';
import 'package:rave_flutter/src/models/momo_response.dart';

abstract class Source {
  Future<MoMoResponse> sendMomoRequest(MoMoRequest requestBody);
}
