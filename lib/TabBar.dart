import 'package:flutter/material.dart';
import 'WalletAndCryptoLabelsWidget.dart';
import 'Transactions.dart';
import 'l10n/app_localizations.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);
  static const selectedCriptoScreen = '/selected_cripto';

  @override
  State<BottomNavigationBarWidget> createState() => TabBarState();
}

class TabBarState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const WalletAndCryptoLabelsWidget(),
    const Text(
      'Home',
    ),
    const TransactionsWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 3, 0, 0),
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("lib/icon/warren.png"),
                color: Color.fromARGB(255, 254, 4, 4)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.card_travel),
            label: AppLocalizations.of(context)!.wallets,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.toll_outlined),
            label: AppLocalizations.of(context)!.transactions,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
