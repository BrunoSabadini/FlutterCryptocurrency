import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class CryptoListingEndpoint {
  final Dio _dio;

  CryptoListingEndpoint(this._dio);

  Future<Response> getAllCryptoInfo() {
    return _dio.get("/v2/assets");
  }

  Future<Response> getAllChartsInfo(String symbol) {
    return _dio.get(
        "/v1/assets/$symbol/metrics/price/time-series?end=2022-06-01&interval=1d");
  }

  String filterEndPointStartDate() {
    final DateTime nowTime = DateTime.now();
    final DateFormat formatActualTime = DateFormat('yyyy-MM-dd');
    final String actualTime = formatActualTime.format(nowTime);
    return actualTime;
  }

  endPointPickAccordingToSymbol(String symbol) {
    switch (symbol) {
      case "BTC":
        return 'https://data.messari.io/api/v1/assets/btc/metrics/price/time-series?end=${filterEndPointStartDate()}&interval=1d';
      case "ETH":
        return 'https://data.messari.io/api/v1/assets/eth/metrics/price/time-series?end=${filterEndPointStartDate()}&interval=1d';
      case "LTC":
        return 'https://data.messari.io/api/v1/assets/ltc/metrics/price/time-series?end=${filterEndPointStartDate()}&interval=1d';
      default:
        "No symbol found";
    }
  }
}
