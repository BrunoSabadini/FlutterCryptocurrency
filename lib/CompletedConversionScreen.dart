import 'package:flutter/material.dart';

import 'l10n/app_localizations.dart';

class CompletedConversionScreen extends StatelessWidget {
  const CompletedConversionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color.fromARGB(82, 98, 255, 0),
            child: IconButton(
              icon: const Icon(
                Icons.check,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushNamed("/");
              },
            ),
          ),
          ListTile(
              title: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.coinconversion,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 25.0),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              subtitle: Row(
                children: [
                  Text(AppLocalizations.of(context)!
                      .sucessfulycoinconversioncompleted)
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ))
        ])));
  }
}
