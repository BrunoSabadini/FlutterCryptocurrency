import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:work_project/API/repositories/MessariAPI/DetailsPage/BigDataModel.dart';
import 'package:work_project/API/repositories/cryptoUseCases.dart';
import 'package:work_project/StateController.dart';
import '../MaterialAppAndProviderInstancesWidget.dart';
import '../l10n/app_localizations.dart';

class DetailsPageModelWidget extends riverpod.ConsumerStatefulWidget {
  const DetailsPageModelWidget({
    Key? key,
  }) : super(key: key);

  @override
  riverpod.ConsumerState<DetailsPageModelWidget> createState() =>
      DetailsPageModelState();
}

class DetailsPageModelState
    extends riverpod.ConsumerState<DetailsPageModelWidget> {
  bool changeChartType = true;
  List<ChartSampleData> chartSpots = <ChartSampleData>[];
  List chartValues = [];
  double minValue = 0;
  double maxValue = 0;
  String? name;
  int numberOfSpots = 50;
  String symbol = '';

  String filterEndPointStartDate() {
    final DateTime nowTime = DateTime.now();
    final DateFormat formatActualTime = DateFormat('yyyy-MM-dd');
    final String actualTime = formatActualTime.format(nowTime);
    return actualTime;
  }

  endPointPickAccordingToSymbol() {
    return 'https://data.messari.io/api/v1/assets/$symbol/metrics/price/time-series?end=${filterEndPointStartDate()}&interval=1d';
  }

  List<ChartSampleData> dateFilter(
      int numberOfSpots, List<dynamic> valuesAndPercentages) {
    chartSpots = <ChartSampleData>[];
    chartValues = [];

    for (var i = 0; i < numberOfSpots; i++) {
      List<dynamic> apiListValuesReversed =
          valuesAndPercentages.reversed.toList();

      chartValues.add(apiListValuesReversed[i][4]);

      List<DateTime> chartDays = [];
      chartDays.add(DateTime.now().subtract(Duration(days: i)));
      chartSpots.add(
          ChartSampleData(period: chartDays.last, yValue: chartValues.last));
    }

    return chartSpots;
  }

  currentCoinValue(num coinValue) {
    switch (symbol) {
      case "BTC":
        return coinValue;
      case "ETH":
        return coinValue;
      case "LTC":
        return coinValue;
    }
  }

  double calculateMinAndMaxValue(String minOrMaxValue) {
    double value = chartValues.first;

    if (minOrMaxValue == "min") {
      for (var i = 0; i < chartSpots.length; i++) {
        value = min(value, chartValues[i]);
        minValue = value;
      }
    } else {
      for (var i = 0; i < chartSpots.length; i++) {
        value = max(value, chartValues[i]);
        maxValue = value;
      }
    }
    return value.toDouble();
  }

  void callChartData(int nOfSpots, List<dynamic> valuesAndPercentages) {
    setState(() {
      numberOfSpots = nOfSpots;
      minValue = calculateMinAndMaxValue("min");
      maxValue = calculateMinAndMaxValue("max");
    });
  }

  void switchChartType() {
    setState(() {
      changeChartType = !changeChartType;
    });
  }

  Widget chartWidget(num coinValue) {
    return Container(
        margin: const EdgeInsets.only(top: 20.0, right: 25, left: 25),
        height: 300,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                  child: SizedBox(
                      height: 250,
                      width: 100,
                      child: SfCartesianChart(
                          title: ChartTitle(
                              text: Provider.of<StoreStateController>(context,
                                      listen: true)
                                  .numberFormatConversion(
                                      currentCoinValue(coinValue))),
                          backgroundColor:
                              const Color.fromARGB(94, 224, 219, 219),
                          primaryXAxis: DateTimeAxis(
                              maximumLabels: 50,
                              majorGridLines: const MajorGridLines(width: 0),
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              intervalType: DateTimeIntervalType.days),
                          series: (changeChartType)
                              ? <ChartSeries<ChartSampleData, DateTime>>[
                                  LineSeries<ChartSampleData, DateTime>(
                                    dataSource: chartSpots,
                                    xValueMapper: (ChartSampleData sales, _) =>
                                        sales.period,
                                    yValueMapper: (ChartSampleData sales, _) =>
                                        sales.yValue,
                                  )
                                ]
                              : <ChartSeries<ChartSampleData, DateTime>>[
                                  BarSeries<ChartSampleData, DateTime>(
                                    dataSource: chartSpots,
                                    xValueMapper: (ChartSampleData sales, _) =>
                                        sales.period,
                                    yValueMapper: (ChartSampleData sales, _) =>
                                        sales.yValue,
                                  )
                                ])))
            ]),
          ],
        ));
  }

  List<ChartSampleData> sampleData(BigDataModel data) {
    return dateFilter(numberOfSpots, data.values);
  }

  chartButton(
      int numberOfSpots, String label, List<dynamic> valuesAndPercentages) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: OutlinedButton(
        onPressed: () {
          callChartData(numberOfSpots, valuesAndPercentages);
        },
        child: Text(label),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.indigo[50]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    symbol = args.symbol;
    final getCryptoListingProvider = ref.watch(detailsPageProvider(symbol));
    return getCryptoListingProvider.when(
        data: (data) => Scaffold(
            appBar: AppBar(
                iconTheme: const IconThemeData(
                  color: Colors.black,
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pushNamed("/");
                  },
                ),
                toolbarOpacity: 0.5,
                backgroundColor: const Color.fromARGB(193, 255, 255, 255),
                title: SizedBox(
                  width: double.infinity,
                  child: Text(AppLocalizations.of(context)!.details,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                )),
            body: ListView(children: <Widget>[
              Text(AppLocalizations.of(context)!.coin + " " + (data.name ?? ""),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Container(
                  margin: const EdgeInsets.only(top: 20.0, right: 25, left: 25),
                  height: 300,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(
                            child: SizedBox(
                                height: 250,
                                width: 100,
                                child: SfCartesianChart(
                                    title: ChartTitle(
                                        text: Provider.of<StoreStateController>(
                                                context,
                                                listen: true)
                                            .numberFormatConversion(
                                                currentCoinValue(data
                                                    .values.last[4]
                                                    .toDouble()))),
                                    backgroundColor:
                                        const Color.fromARGB(94, 224, 219, 219),
                                    primaryXAxis: DateTimeAxis(
                                        maximumLabels: 50,
                                        majorGridLines:
                                            const MajorGridLines(width: 0),
                                        edgeLabelPlacement:
                                            EdgeLabelPlacement.shift,
                                        intervalType:
                                            DateTimeIntervalType.days),
                                    series: (changeChartType)
                                        ? <ChartSeries<ChartSampleData, DateTime>>[
                                            LineSeries<ChartSampleData,
                                                DateTime>(
                                              dataSource: sampleData(data),
                                              xValueMapper:
                                                  (ChartSampleData sales, _) =>
                                                      sales.period,
                                              yValueMapper:
                                                  (ChartSampleData sales, _) =>
                                                      sales.yValue,
                                            )
                                          ]
                                        : <ChartSeries<ChartSampleData, DateTime>>[
                                            BarSeries<ChartSampleData,
                                                DateTime>(
                                              dataSource: sampleData(data),
                                              xValueMapper:
                                                  (ChartSampleData sales, _) =>
                                                      sales.period,
                                              yValueMapper:
                                                  (ChartSampleData sales, _) =>
                                                      sales.yValue,
                                            )
                                          ])))
                      ]),
                    ],
                  )),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    chartButton(5, '5D', data.values),
                    chartButton(10, '10D', data.values),
                    chartButton(15, '15D', data.values),
                    chartButton(30, '30D', data.values),
                    chartButton(50, '50D', data.values),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: OutlinedButton(
                        onPressed: () {
                          switchChartType();
                        },
                        child: const Icon(Icons.bar_chart),
                        style: (1 != 1)
                            ? ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.grey),
                              )
                            : ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.indigo[50]),
                              ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 15),
                  child: Text(AppLocalizations.of(context)!.informations,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            width: 1.1, color: Color.fromARGB(60, 0, 0, 0)))),
                child: Provider.of<StoreStateController>(context, listen: false)
                    .listTile((name ?? ""),
                        currentCoinValue(data.values.last[4].toDouble()),
                        subtitle:
                            Text(AppLocalizations.of(context)!.actualvalue)),
              ),
              Provider.of<StoreStateController>(context, listen: false)
                  .listTile(AppLocalizations.of(context)!.marketcap, 10,
                      backgroundColorVerification: 10, whatStringReturn: ""),
              Provider.of<StoreStateController>(context, listen: false)
                  .listTile(
                      AppLocalizations.of(context)!.minimumvalue, minValue),
              Provider.of<StoreStateController>(context, listen: false)
                  .listTile(
                      AppLocalizations.of(context)!.maximumvalue, maxValue),
              Provider.of<StoreStateController>(context, listen: false)
                  .elevatedButton(
                      context, AppLocalizations.of(context)!.coinconversion,
                      routeNavigator: 'coinConversion'),
            ])),
        error: (Object error, StackTrace? stackTrace) =>
            const Text('API Request Failed'),
        loading: () => Provider.of<StoreStateController>(context, listen: false)
            .animation);
  }
}

class ChartSampleData {
  ChartSampleData({this.period, this.yValue});

  final DateTime? period;
  final num? yValue;
}
