import 'package:flutter/material.dart';

import '../../core/constants/app_barrel.dart';
import '../../core/extensions/theme_x.dart';
import '../../core/localization/app_localizations.dart';
import '../shared/ui_helper.dart';

class PaymentMethodPage extends StatelessWidget {
  final List<String> cards = ['PayLah!', 'Visa', 'XX 4690'];

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(15.0),
        color: context.theme().scaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(child: Icon(Icons.drag_handle)),
            Text(
              locale.paymentMethodTitle,
              style: context.textTheme().headline6,
            ),
            UIHelper.verticalSpaceMedium(),
            Container(
              height: 210.0,
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: 3,
                itemBuilder: (context, index) => _PaymentMethodCardView(
                    title: cards[index],
                    paymentMethodCallback: () {
                      print('tapped');
                    }),
              ),
            ),
            _CashItemView(),
          ],
        ),
      ),
    );
  }
}

class _PaymentMethodCardView extends StatelessWidget {
  final String title;
  final VoidCallback paymentMethodCallback;

  const _PaymentMethodCardView({Key key, @required this.title, @required this.paymentMethodCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      height: 50.0,
      child: Row(
        children: <Widget>[
          Image.asset(
            AssetImages.ill1,
            width: 25.0,
            height: 25.0,
            fit: BoxFit.cover,
          ),
          UIHelper.horizontalSpaceMedium(),
          Text(title, style: context.textTheme().subtitle2),
          Spacer(),
          IconButton(icon: Icon(title == 'Visa' ? Icons.radio_button_checked : Icons.radio_button_unchecked), iconSize: 17.0, onPressed: paymentMethodCallback),
        ],
      ),
    );
  }
}

class _CashItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            AssetImages.ill1,
            width: 25.0,
            height: 25.0,
            fit: BoxFit.cover,
          ),
          UIHelper.horizontalSpaceMedium(),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Cash', style: context.textTheme().subtitle2),
                UIHelper.verticalSpaceExtraSmall(),
                Text(
                  'Avoid hassie by keeping the exact amount ready',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(icon: Icon(Icons.radio_button_unchecked), iconSize: 17.0, onPressed: () {}),
        ],
      ),
    );
  }
}
