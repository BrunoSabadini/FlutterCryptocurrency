import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class StoreStateController extends ChangeNotifier {
  IconData eyeShow = Icons.visibility_rounded;
  IconData eyeHide = Icons.visibility_off_rounded;
  bool showHide = false;
  String hideWallet = "----------------";
  String profit = "+\$ 100,00";
  String remuneration = "(100% do CDI)";
  double bitcoinCurrentValue = 1000;
  double litecoinCurrentValue = 2000;
  double ethereumCurrentValue = 3000;
  double bitcoinAmount = 60000.00;
  double litecoinAmount = 40000.00;
  double ethereumAmount = 30000.00;
  String pickWhichCoinConvert = "";
  double percentageToConvert = 0;
  double wichCoinAmount = 0;
  final animation = const LoadingAnimationWidget();

  double walletAmount() {
    return bitcoinAmount + litecoinAmount + ethereumAmount;
  }

  Widget listTile(
    String title,
    double trailingValue, {
    Widget? subtitle,
    String whatStringReturn = "\$",
    num? backgroundColorVerification,
    String? textTest,
    Icon? icon,
  }) {
    return ListTile(
      leading: icon,
      title: Text(title),
      subtitle: subtitle,
      trailing: greenOrRedBackground(
          text: numberFormatConversion(trailingValue,
              whatStringReturn: whatStringReturn),
          backgroundColorVerification: backgroundColorVerification),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    );
  }

  wichCoinConvert() {
    if (pickWhichCoinConvert == 'Bitcoin') {
      return bitcoinAmount;
    }
    if (pickWhichCoinConvert == 'Ethereum') {
      return ethereumAmount;
    }
    if (pickWhichCoinConvert == 'Litecoin') {
      return litecoinAmount;
    } else {
      return print("Correct the coin conversion");
    }
  }

  double coinAmountConversionAccordingToPercentage() {
    if (percentageToConvert == 25) {
      return wichCoinConvert() * 0.25;
    }
    if (percentageToConvert == 50) {
      return wichCoinConvert() * 0.50;
    }
    if (percentageToConvert == 75) {
      return wichCoinConvert() * 0.75;
    }
    if (percentageToConvert == 100) {
      return wichCoinConvert() * 1;
    } else {
      return 0;
    }
  }

  Widget greenOrRedBackground(
      {String text = "", num? backgroundColorVerification}) {
    if (backgroundColorVerification == null) {
      return Container(
        margin: const EdgeInsets.only(top: 10.0),
        width: 90,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 13.0),
        ),
      );
    }
    if (backgroundColorVerification > 0) {
      return Container(
        margin: const EdgeInsets.only(top: 10.0),
        width: 70,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Color.fromARGB(255, 188, 255, 190)),
        child: Text(
          "+" + text + "%",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 13.0),
        ),
      );
    } else {
      return Container(
          margin: const EdgeInsets.only(top: 10.0),
          width: 70,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Color.fromARGB(157, 255, 136, 136)),
          child: Text(
            text + "%",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13.0),
          ));
    }
  }

  Widget elevatedButton(
    BuildContext context,
    String text, {
    Color backgroundButtonColor = const Color.fromARGB(255, 221, 48, 85),
    Color textButtonColor = const Color.fromARGB(255, 255, 255, 255),
    double fontSize = 20,
    String routeNavigator = "Go to Error Screen",
  }) {
    return ElevatedButton(
      child: Text(text),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pushNamed(routeNavigator);
      },
      style: ElevatedButton.styleFrom(
          onPrimary: textButtonColor,
          primary: backgroundButtonColor,
          textStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  void switchShowHide() {
    showHide = !showHide;
    notifyListeners();
  }

  eyefunc() {
    if (showHide == false) {
      return eyeShow;
    } else {
      return eyeHide;
    }
  }

  amountFunc(double bitcoinAmount) {
    if (showHide == false) {
      return numberFormatConversion(bitcoinAmount);
    } else {
      return hideWallet;
    }
  }

  String numberFormatConversion(double value,
      {String whatStringReturn = "\$"}) {
    return intl.NumberFormat.currency(locale: 'en_US', name: whatStringReturn)
        .format(value);
  }

  profitFunc() {
    if (showHide == false) {
      return profit;
    } else {
      return "";
    }
  }

  remunerationFunc() {
    if (showHide == false) {
      return remuneration;
    } else {
      return "";
    }
  }
}

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
