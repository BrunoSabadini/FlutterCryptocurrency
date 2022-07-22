import 'package:dio/dio.dart';

class CryptosEndPoint {
  final Dio _dio;

  CryptosEndPoint(this._dio);

  Future<Response> getWalletPageData() {
    return _dio.get("/v2/assets");
  }

  Future<Response> getDetailsPageData(String symbol) {
    return _dio.get(
        "/v1/assets/$symbol/metrics/price/time-series?end=2022-06-01&interval=1d");
  }
}
