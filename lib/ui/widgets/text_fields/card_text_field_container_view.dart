import 'package:flutter/material.dart';

import '../../../core/services/local_storage_service.dart';
import '../../../locator.dart';

class CardTextFieldContainerView extends StatelessWidget {
  final Widget child;

  const CardTextFieldContainerView({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localStorageService = locator<LocalStorageService>();
    return SizedBox(
      height: 70.0,
      child: Card(
        color: localStorageService.darkMode ? Colors.grey[700] : Colors.white,
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: child,
        ),
      ),
    );
  }
}
