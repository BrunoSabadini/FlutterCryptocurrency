import 'package:dio/dio.dart';
import 'AllAssetsBigDataModel.dart';

class AllAssetsRepository {
  static String mainUrl = "https://data.messari.io/api";
  static String allAssets = '$mainUrl/v2/assets';

  final String apiKey = "8d38948c-555a-426f-bf5e-1b70abc6bea6";

  final Dio _dio = Dio();
  Future<AllAssetsBigDataModel> getCoins() async {
    try {
      _dio.options.headers["x-messari-api-key"] = apiKey;
      Response response = await _dio.get(allAssets);
      return AllAssetsBigDataModel.fromJson((response.data));
    } catch (error) {
      return AllAssetsBigDataModel.withError("Deu ruim");
    }
  }
}
