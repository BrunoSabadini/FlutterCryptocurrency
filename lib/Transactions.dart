import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'StateController.dart';
import 'l10n/app_localizations.dart';

class TransactionsState extends State<TransactionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      ListView(children: <Widget>[
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 0, 10),
            child: Text(AppLocalizations.of(context)!.informations,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black))),
        Provider.of<StoreSharedStateControllers>(context, listen: true)
            .listTile("ETH", 2000,
                icon: const Icon(Icons.currency_exchange_outlined),
                subtitle: const Text("31/12/2022")),
      ])
    ]));
  }
}

class TransactionsWidget extends StatefulWidget {
  const TransactionsWidget({Key? key}) : super(key: key);

  @override
  State<TransactionsWidget> createState() => TransactionsState();
}
