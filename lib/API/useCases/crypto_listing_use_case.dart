import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:work_project/API/repositories/MessariAPI/AllAssetsBigDataModel.dart';
import 'package:work_project/API/repositories/MessariAPI/BigDataModel.dart';
import 'package:work_project/API/repositories/crypto_listing_repository_provider.dart';

import '../repositories/crypto_listing_repository.dart';

class GetCryptoListingUseCase {
  final CryptosRepository repository;
  GetCryptoListingUseCase({required this.repository});

  Future<AllAssetsBigDataModel> execute() async {
    await Future.delayed(const Duration(seconds: 2));
    final response = await repository.recieveWalletPageData();

    return response;
  }

  Future<BigDataModel> start(String symbol) async {
    await Future.delayed(const Duration(seconds: 2));
    final response = await repository.recieveDetailsPageData(symbol);

    return response;
  }
}

final cryptoListingRepositoryProvider = Provider((ref) {
  return CryptosRepository(cryptosEndPoint: ref.read(endPointMessariAPI));
});

final walletPageProviderUseCase = Provider((ref) {
  return GetCryptoListingUseCase(
      repository: ref.read(cryptoListingRepositoryProvider));
});

final walletPageProvider = FutureProvider<AllAssetsBigDataModel>((ref) async {
  return ref.read(walletPageProviderUseCase).execute();
});

final detailsPageProvider = FutureProvider.autoDispose
    .family<BigDataModel, String>((ref, symbol) async {
  return ref.read(walletPageProviderUseCase).start(symbol);
});
