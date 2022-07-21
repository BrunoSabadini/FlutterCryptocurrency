import 'package:dio/dio.dart';
import 'BigDataModel.dart';

class Repository {
  String endPoint;

  Repository(
    this.endPoint,
  );

  final String apiKey = "8d38948c-555a-426f-bf5e-1b70abc6bea6";

  final Dio _dio = Dio();
  Future<BigDataModel> getCoins() async {
    try {
      _dio.options.headers["x-messari-api-key"] = apiKey;
      Response response = await _dio.get(endPoint);
      return BigDataModel.fromJson((response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BigDataModel.withError("", "", "", "");
    }
  }
}
