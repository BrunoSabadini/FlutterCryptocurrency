import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:work_project/API/repositories/MessariAPI/AllAssetsBigDataModel.dart';
import 'package:work_project/API/repositories/MessariAPI/BigDataModel.dart';

import '../repositories/crypto_listing_endpoint_provider.dart';
import '../repositories/crypto_listing_repository.dart';

class GetCryptoListingUseCase {
  final CryptoListingRepository repository;
  GetCryptoListingUseCase({required this.repository});

  Future<AllAssetsBigDataModel> execute() async {
    await Future.delayed(const Duration(seconds: 2));
    final response = await repository.getAllCryptoInfo();

    return response;
  }

  Future<BigDataModel> start(String symbol) async {
    await Future.delayed(const Duration(seconds: 2));
    final response = await repository.getAllChartsInfo(symbol);

    return response;
  }
}

final cryptoListingRepositoryProvider = Provider((ref) {
  return CryptoListingRepository(
      cryptoListingEndpoint: ref.read(cryptoListingEndpointProvider));
});

final getCryptoListingUseCase = Provider((ref) {
  return GetCryptoListingUseCase(
      repository: ref.read(cryptoListingRepositoryProvider));
});

final cryptoListingProvider =
    FutureProvider<AllAssetsBigDataModel>((ref) async {
  return ref.read(getCryptoListingUseCase).execute();
});

final chartsListingProvider = FutureProvider.autoDispose
    .family<BigDataModel, String>((ref, symbol) async {
  return ref.read(getCryptoListingUseCase).start(symbol);
});
