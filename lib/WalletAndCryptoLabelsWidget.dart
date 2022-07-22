import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';
import 'package:work_project/API/repositories/cryptoUseCases.dart';
import 'package:work_project/StateController.dart';
import '../l10n/app_localizations.dart';

import 'TabBar.dart';

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
  double wichCoinAmount(String symbol) {
    switch (symbol) {
      case "BTC":
        return Provider.of<StoreStateController>(context, listen: true)
            .ethereumAmount;
      case "ETH":
        return Provider.of<StoreStateController>(context, listen: true)
            .ethereumAmount;
      case "LTC":
        return Provider.of<StoreStateController>(context, listen: true)
            .litecoinAmount;
      default:
        return 0.010101010101;
    }
  }

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
                  child: Text(
                      AppLocalizations.of(context)!
                          .wallet, // Deixei "Carteira" mesmo em inglês porque ele reconhece que estou usando inglês
                      style: const TextStyle(
                          fontSize: 29, fontWeight: FontWeight.bold))),
              IconButton(
                icon: Icon(
                    Provider.of<StoreStateController>(context, listen: true)
                        .eyefunc()),
                tooltip: 'HideWalletAmount',
                onPressed:
                    Provider.of<StoreStateController>(context, listen: true)
                        .switchShowHide,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(
                child: Text(
                    Provider.of<StoreStateController>(context, listen: true)
                        .amountFunc(Provider.of<StoreStateController>(context,
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
                      Provider.of<StoreStateController>(context, listen: true)
                              .profitFunc() +
                          " " +
                          Provider.of<StoreStateController>(context,
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
            Text(Provider.of<StoreStateController>(context, listen: true)
                .amountFunc(wichCoinAmount(symbol))),
            (Provider.of<StoreStateController>(context, listen: true)
                .greenOrRedBackground(
                    text: marketCap.toStringAsFixed(2),
                    backgroundColorVerification: marketCap))
          ]),
          isThreeLine: true,
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
        data: (data) => Stack(children: <Widget>[
              ListView(children: [
                walletAmountWidget(),
                ...data.dataModel.map((coinsData) => Tooltip(
                    message: "Go to ${coinsData.symbol} details",
                    child: coinsLabel(
                      coinsData.slug,
                      coinsData.name,
                      coinsData.metrics["market_data"]
                          ["percent_change_eth_last_24_hours"],
                      coinsData.symbol,
                    )))
              ])
            ]),
        error: (Object error, StackTrace? stackTrace) => const Text('Erro'),
        loading: () => animation);
  }
}

const animation = LoadingAnimationWidget();

class LoadingAnimationWidget extends StatefulWidget {
  const LoadingAnimationWidget({Key? key}) : super(key: key);

  @override
  State<LoadingAnimationWidget> createState() => LoadingAnimationState();
}

class LoadingAnimationState extends State<LoadingAnimationWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: _offsetAnimation,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: ImageIcon(
            AssetImage("lib/icon/warren.png"),
            color: Color.fromARGB(255, 254, 4, 4),
            size: 150,
          ),
        ));
  }
}