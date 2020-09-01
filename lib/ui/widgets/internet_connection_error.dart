import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_barrel.dart';
import '../../core/constants/asset_images.dart';
import '../../core/extensions/theme_x.dart';
import '../../core/localization/app_localizations.dart';
import '../shared/ui_helper.dart';

enum ConnectivityStatus {
  wifi,
  cellular,
  offline,
}

class InternetConnectionError extends StatelessWidget {
  final Widget child;

  const InternetConnectionError({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    final ConnectivityStatus connectivityStatus = context.watch<ConnectivityStatus>();

    if (connectivityStatus == null) {
      return child;
    }

    switch (connectivityStatus) {
      case ConnectivityStatus.wifi:
        return child;
      case ConnectivityStatus.cellular:
        return child;
      default:
        return Scaffold(
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(AssetImages.noInternet, width: 250.0, height: 250.0),
                Text(locale.noInternetError, style: context.textTheme().headline6.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                UIHelper.verticalSpaceMedium(),
                Text(locale.checkInternetError, style: context.textTheme().bodyText1.copyWith(color: Colors.grey), textAlign: TextAlign.center),
              ],
            ),
          ),
        );
    }
  }
}
