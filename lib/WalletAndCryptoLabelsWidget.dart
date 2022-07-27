import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';
import 'package:work_project/API/repositories/cryptoUseCases.dart';
import 'package:work_project/StateController.dart';
import '../l10n/app_localizations.dart';

import 'BottomNavigationBar.dart';

import 'MaterialAppAndProviderInstancesWidget.dart';

class WalletAndCryptoLabelsWidget extends riverpod.ConsumerStatefulWidget {
  const WalletAndCryptoLabelsWidget({
    Key? key,
  }) : super(key: key);

  @override
  riverpod.ConsumerState<WalletAndCryptoLabelsWidget> createState() =>
      WalletAndCryptoLabelsState();
}

class WalletAndCryptoLabelsState
    extends riverpod.ConsumerState<WalletAndCryptoLabelsWidget> {
  Widget walletAmountWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(25, 40, 25, 0),
      height: 150.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(AppLocalizations.of(context)!.wallet,
                      style: const TextStyle(
                          fontSize: 29, fontWeight: FontWeight.bold))),
              IconButton(
                icon: Icon(Provider.of<StoreSharedStateControllers>(context,
                        listen: true)
                    .eyefunc()),
                tooltip: 'HideWalletAmount',
                onPressed: Provider.of<StoreSharedStateControllers>(context,
                        listen: true)
                    .switchShowHide,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(
                child: Text(
                    Provider.of<StoreSharedStateControllers>(context,
                            listen: true)
                        .amountFunc(Provider.of<StoreSharedStateControllers>(
                                context,
                                listen: true)
                            .walletAmount()),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 29, fontWeight: FontWeight.bold))),
            const IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              tooltip: 'GoToAmountDetails',
              onPressed: null,
            )
          ]),
          Row(
            children: [
              Expanded(
                  child: Text(
                      Provider.of<StoreSharedStateControllers>(context,
                                  listen: true)
                              .profitFunc() +
                          " " +
                          Provider.of<StoreSharedStateControllers>(context,
                                  listen: true)
                              .remunerationFunc(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 19)))
            ],
          )
        ],
      ),
    );
  }

  Widget coinsLabel(String slug, String name, double marketCap, String symbol) {
    double wichCoinAmount() {
      switch (symbol) {
        case "BTC":
          return Provider.of<StoreSharedStateControllers>(context, listen: true)
              .bitcoinAmount;
        case "ETH":
          return Provider.of<StoreSharedStateControllers>(context, listen: true)
              .ethereumAmount;
        case "LTC":
          return Provider.of<StoreSharedStateControllers>(context, listen: true)
              .litecoinAmount;
        default:
          return 0;
      }
    }

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            BottomNavigationBarWidget.selectedCriptoScreen,
            arguments: ScreenArguments(
              symbol,
            ),
          );
        },
        child: ListTile(
          leading: slug == "bitcoin"
              ? const Icon(Icons.currency_bitcoin, size: 35)
              : slug == "ethereum"
                  ? const Icon(Icons.e_mobiledata_rounded, size: 45)
                  : slug == "litecoin"
                      ? const Icon(Icons.currency_lira_outlined, size: 35)
                      : const Icon(Icons.currency_bitcoin, size: 35),
          title: Text(symbol),
          subtitle: Text(name),
          trailing: Column(children: [
            Text(Provider.of<StoreSharedStateControllers>(context, listen: true)
                .amountFunc(wichCoinAmount())),
            (Provider.of<StoreSharedStateControllers>(context, listen: true)
                .greenOrRedBackground(
                    text: marketCap.toStringAsFixed(2),
                    backgroundColorVerification: marketCap))
          ]),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final getCryptoListingProvider = ref.watch(walletPageProvider);

    return getCryptoListingProvider.when(
        data: (allAssetsBigDataModel) => Stack(children: <Widget>[
              ListView(children: [
                walletAmountWidget(),
                ...allAssetsBigDataModel.dataModel
                    .where((element) =>
                        element.symbol == 'BTC' ||
                        element.symbol == 'ETH' ||
                        element.symbol == 'LTC')
                    .map((allAssetsBigDataModel) => Tooltip(
                        message:
                            "Go to ${allAssetsBigDataModel.symbol} details",
                        child: coinsLabel(
                          allAssetsBigDataModel.slug,
                          allAssetsBigDataModel.name,
                          allAssetsBigDataModel.metrics["market_data"]
                              ["percent_change_eth_last_24_hours"],
                          allAssetsBigDataModel.symbol,
                        )))
              ])
            ]),
        error: (Object error, StackTrace? stackTrace) => const Text('Erro'),
        loading: () =>
            Provider.of<StoreSharedStateControllers>(context, listen: false)
                .animation);
  }
}
