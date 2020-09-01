import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/extensions/theme_x.dart';
import '../../core/view_models/cart_badge_view_model.dart';

class CartBadgeIcon extends StatelessWidget {
  final VoidCallback onPressed;

  const CartBadgeIcon({Key key, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartBadgeViewModel>(
      builder: (context, model, child) => Stack(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: onPressed,
          ),
          Positioned(
            top: 1.0,
            right: 1.0,
            child: Stack(
              children: <Widget>[
                Icon(
                  Icons.brightness_1,
                  size: 20.0,
                  color: context.theme().accentColor,
                ),
                Positioned(
                  top: 1.1,
                  right: 6.0,
                  child: Text('${model.courseCount}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 14.0,
                        color: Colors.white,
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
