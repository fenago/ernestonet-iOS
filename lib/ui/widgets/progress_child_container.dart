import 'package:flutter/material.dart';
import '../../core/extensions/media_query_x.dart';

class ProgressChildContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final bool busy;

  const ProgressChildContainer({Key key, @required this.child, this.blur = 0.5, this.busy = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (busy) {
      return Container(
        height: context.mediaQuerySize().height,
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            child,
            AbsorbPointer(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      );
    }
    return child;
  }
}
