import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:work_project/StateController.dart';

import 'l10n/app_localizations.dart';

class CoinsConversionWidget extends StatefulWidget {
  const CoinsConversionWidget({Key? key}) : super(key: key);

  @override
  State<CoinsConversionWidget> createState() => CoinsConversionState();
}

class CoinsConversionState extends State<CoinsConversionWidget> {
  String selectWichCoinConvert = 'Bitcoin';
  String selectToWichCoinConvert = 'Bitcoin';
  String conversionFieldAmount = "";
  String convertedFieldAmount = "";
  double receiveCoinAmountAccordingToPercentage = 0;
  String textToConversionField = "Montante a ser convertido";
  String textToConvertedField = "Montante após conversão";
  int myIntVar = 0;
  double percentageVar = 0;

  String recieveTypedFieldValues = "";

  var items = [
    'Bitcoin',
    'Ethereum',
    'Litecoin',
  ];

  var items2 = [
    'Bitcoin',
    'Ethereum',
    'Litecoin',
  ];

  double convertCoin() {
    double currentValueConvertedCoin = 0;
    double currentValueConvertedToCoin = 0;
    double resultAfterConversion = 0;

    if (selectWichCoinConvert == 'Bitcoin') {
      currentValueConvertedCoin =
          Provider.of<StoreStateController>(context, listen: false)
              .bitcoinCurrentValue;
    }
    if (selectWichCoinConvert == 'Ethereum') {
      currentValueConvertedCoin =
          Provider.of<StoreStateController>(context, listen: false)
              .ethereumCurrentValue;
    }
    if (selectWichCoinConvert == 'Litecoin') {
      currentValueConvertedCoin =
          Provider.of<StoreStateController>(context, listen: false)
              .litecoinCurrentValue;
    }
    if (selectToWichCoinConvert == 'Bitcoin') {
      currentValueConvertedToCoin =
          Provider.of<StoreStateController>(context, listen: false)
              .bitcoinCurrentValue;
    }
    if (selectToWichCoinConvert == 'Ethereum') {
      currentValueConvertedToCoin =
          Provider.of<StoreStateController>(context, listen: false)
              .ethereumCurrentValue;
    }
    if (selectToWichCoinConvert == 'Litecoin') {
      currentValueConvertedToCoin =
          Provider.of<StoreStateController>(context, listen: false)
              .litecoinCurrentValue;
    }
    resultAfterConversion =
        (currentValueConvertedCoin / currentValueConvertedToCoin) *
            receiveCoinAmountAccordingToPercentage;

    return resultAfterConversion;
  }

  Widget conversionField(String staticConversionFieldText) {
    return TextFormField(
      controller: TextEditingController(text: recieveTypedFieldValues),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: staticConversionFieldText,
      ),
    );
  }

  Widget percetageToConvertCoin(double percentage) {
    Provider.of<StoreStateController>(context, listen: false)
        .pickWhichCoinConvert = selectWichCoinConvert;

    return Center(
        child: SizedBox(
            width: 60,
            child: Material(
                child: InkWell(
                    onTap: () {
                      Provider.of<StoreStateController>(context, listen: false)
                          .percentageToConvert = percentage;
                      receiveCoinAmountAccordingToPercentage =
                          Provider.of<StoreStateController>(context,
                                  listen: false)
                              .coinAmountConversionAccordingToPercentage();
                      setState(() {
                        textToConversionField =
                            Provider.of<StoreStateController>(context,
                                    listen: false)
                                .numberFormatConversion(
                                    receiveCoinAmountAccordingToPercentage);
                      });
                      textToConvertedField = Provider.of<StoreStateController>(
                              context,
                              listen: false)
                          .numberFormatConversion(convertCoin());
                      percentageVar = percentage;
                    },
                    child: Container(
                        child: Text(
                          "$percentage" "%",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 0, 0, 0)),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(10.0))))))));
  }

  Widget textTitles(String text, {double fontsize = 24}) {
    return Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: fontsize,
            fontWeight: FontWeight.bold,
            color: Colors.black));
  }

  refreshAmountAccordingToCoinItemSelection(String? newValue) {
    setState(() {
      selectWichCoinConvert = newValue!;
      Provider.of<StoreStateController>(context, listen: false)
          .percentageToConvert = percentageVar;
      receiveCoinAmountAccordingToPercentage =
          Provider.of<StoreStateController>(context, listen: false)
              .coinAmountConversionAccordingToPercentage();
      setState(() {
        textToConversionField =
            Provider.of<StoreStateController>(context, listen: false)
                .numberFormatConversion(receiveCoinAmountAccordingToPercentage);
      });
      textToConvertedField =
          Provider.of<StoreStateController>(context, listen: false)
              .numberFormatConversion(convertCoin());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: <Widget>[
      Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 30),
          child: textTitles(AppLocalizations.of(context)!.coinconversion,
              fontsize: 30)),
      Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 30),
          child: textTitles(AppLocalizations.of(context)!.convertcoin)),
      Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 30),
          child: DropdownButton(
            alignment: Alignment.center,
            value: selectWichCoinConvert,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              refreshAmountAccordingToCoinItemSelection(newValue);
            },
          )),
      conversionField(textToConversionField),
      Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 30),
          child: Row(children: [
            Expanded(child: percetageToConvertCoin(25)),
            Expanded(child: percetageToConvertCoin(50)),
            Expanded(child: percetageToConvertCoin(75)),
            Expanded(child: percetageToConvertCoin(100))
          ])),
      Padding(
          padding: const EdgeInsets.fromLTRB(20, 70, 0, 30),
          child: textTitles(AppLocalizations.of(context)!.toreceivein)),
      Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 30),
          child: DropdownButton(
            alignment: Alignment.center,
            value: selectToWichCoinConvert,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items2.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              refreshAmountAccordingToCoinItemSelection(newValue);
            },
          )),
      conversionField(textToConvertedField),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: Row(children: [
          Expanded(
              child: Provider.of<StoreStateController>(context, listen: true)
                  .elevatedButton(context, AppLocalizations.of(context)!.cancel,
                      backgroundButtonColor:
                          const Color.fromARGB(255, 255, 255, 255),
                      textButtonColor: const Color.fromARGB(255, 221, 48, 85),
                      routeNavigator: '/')),
          const Spacer(),
          Expanded(
              child: Provider.of<StoreStateController>(context, listen: true)
                  .elevatedButton(
                      context, AppLocalizations.of(context)!.confirm,
                      routeNavigator: '/completedConversion')),
        ]),
      )
    ]));
  }
}
