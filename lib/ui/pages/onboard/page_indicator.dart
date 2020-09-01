import 'package:flutter/material.dart';
import '../../../core/extensions/padding_x.dart';

class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int pageCount;

  PageIndicator(this.currentIndex, this.pageCount);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildPageIndicators(),
    );
  }

  List<Widget> _buildPageIndicators() {
    List<Widget> indicators = [];
    for (int i = 0; i < pageCount; i++) {
      indicators.add(i == currentIndex ? _indicator(true) : _indicator(false));
    }
    return indicators;
  }

  Expanded _indicator(bool isActive) => Expanded(
        child: Container(
          height: 4.0,
          decoration: BoxDecoration(
            color: isActive ? Colors.black : Colors.blueGrey,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 2.0),
                blurRadius: 2.0,
              )
            ],
          ),
        ).paddingHorizontal(4.0),
      );
}
