import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:work_project/API/repositories/MessariAPI/DetailsPage/BigDataModel.dart';
import 'package:work_project/API/repositories/MessariAPI/WalletPage/AllAssetsBigDataModel.dart';
import 'endPointAndRepository.dart';
import 'package:dio/dio.dart';

final endPointMessariAPI = Provider((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://data.messari.io/api',
  ));
  return CryptosEndPoint(dio);
});

class GetCryptoListingUseCase {
  final CryptosRepository repository;
  GetCryptoListingUseCase({required this.repository});

  Future<AllAssetsBigDataModel> execute() async {
    final response = await repository.recieveWalletPageData();

    return response;
  }

  Future<BigDataModel> start(String symbol) async {
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
