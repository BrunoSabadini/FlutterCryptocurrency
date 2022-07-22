import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'crypto_listing_repository.dart';
import 'package:dio/dio.dart';
import 'crypto_listing_endpoint.dart';

final endPointMessariAPI = Provider((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://data.messari.io/api',
  ));
  return CryptosEndPoint(dio);
});

final cryptoListingRepositoryProvider = Provider((ref) {
  return CryptosRepository(cryptosEndPoint: ref.read(endPointMessariAPI));
});
