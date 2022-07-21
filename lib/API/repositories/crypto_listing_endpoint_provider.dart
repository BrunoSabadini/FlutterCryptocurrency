import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'crypto_listing_endpoint.dart';

final cryptoListingEndpointProvider = Provider((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://data.messari.io/api',
  ));
  return CryptoListingEndpoint(dio);
});
