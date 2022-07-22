import 'package:dio/dio.dart';
import 'package:work_project/API/repositories/MessariAPI/DetailsPage/BigDataModel.dart';
import 'package:work_project/API/repositories/MessariAPI/WalletPage/AllAssetsBigDataModel.dart';

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

class CryptosRepository {
  final CryptosEndPoint cryptosEndPoint;

  CryptosRepository({required this.cryptosEndPoint});

  Future<AllAssetsBigDataModel> recieveWalletPageData() async {
    final result = await cryptosEndPoint.getWalletPageData();
    return AllAssetsBigDataModel.fromJson((result.data));
  }

  Future<BigDataModel> recieveDetailsPageData(String symbol) async {
    final result = await cryptosEndPoint.getDetailsPageData(symbol);
    return BigDataModel.fromJson(result.data);
  }
}
