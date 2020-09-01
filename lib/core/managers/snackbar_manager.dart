import 'package:edustar/core/models/snackbar/snackbar_request.dart';
import 'package:edustar/core/services/snackbar/snackbar.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';

class SnackBarManager extends StatefulWidget {
  final Widget child;

  const SnackBarManager({Key key, this.child}) : super(key: key);

  _SnackBarManagerState createState() => _SnackBarManagerState();
}

class _SnackBarManagerState extends State<SnackBarManager> {
  SnackBarService _snackBarService;

  @override
  void initState() {
    super.initState();
    _snackBarService = locator<SnackBarService>();
    _snackBarService.registerSnackbarListener(_showSnackbar);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showSnackbar(SnackBarRequest request) {
    final SnackBar snackBar = SnackBar(content: Text(request.title));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
