import 'package:dio/dio.dart';
import 'package:rave_flutter/src/models/momo_request.dart';
import 'package:rave_flutter/src/models/momo_response.dart';
import 'package:rave_flutter/src/rave_constants.dart';

import 'source.dart';

class ApiProvider with DioMixin implements Source {
  Dio _dio;

  final String SECRET_KEY;

  ApiProvider(this.SECRET_KEY) {
    _setupDio();
//    setupLoggingInterceptor(_dio);
  }

  _setupDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: RAVE_URL,
        headers: {
          'Authorization': 'Bearer $SECRET_KEY'
        }
      ),
    );

  }

  @override
  Future<MoMoResponse> sendMomoRequest(MoMoRequest requestBody) async{

    try {
      final response = await _dio.post<Map>('/v3/charges?type=mobile_money_uganda',data: requestBody.toJson());
      return MoMoResponse.fromJson(response.data);
    } on DioError catch (e) {
      return Future.error(e);
    } catch (error) {
      return Future.error(error);
    }
  }


}
