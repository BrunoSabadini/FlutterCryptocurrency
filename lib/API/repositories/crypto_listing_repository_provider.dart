import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'crypto_listing_endpoint_provider.dart';
import 'crypto_listing_repository.dart';

final cryptoListingRepositoryProvider = Provider((ref) {
  return CryptoListingRepository(
      cryptoListingEndpoint: ref.read(cryptoListingEndpointProvider));
});
