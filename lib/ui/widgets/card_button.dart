import 'package:custom_buttons/custom_buttons.dart';
import 'package:flutter/material.dart';

import '../../core/extensions/theme_x.dart';

class CardButton extends StatelessWidget {
  final String title;
  final bool busy;
  final VoidCallback onPressed;

  const CardButton({
    Key key,
    @required this.title,
    @required this.onPressed,
    this.busy = false,
  })  : assert(title != ''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomRaisedButton(
        color: context.theme().accentColor,
        elevation: 0.6,
        child: (busy)
            ? Center(
                child: SizedBox(
                height: 25.0,
                width: 25.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ))
            : Text(
                title,
                textAlign: TextAlign.center,
                style: context.textTheme().bodyText2.copyWith(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white),
              ),
        onPressed: onPressed,
      ),
    );
  }
}
