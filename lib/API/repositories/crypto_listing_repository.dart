import 'package:work_project/API/repositories/MessariAPI/AllAssetsBigDataModel.dart';
import 'package:work_project/API/repositories/MessariAPI/BigDataModel.dart';

import 'crypto_listing_endpoint.dart';

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
