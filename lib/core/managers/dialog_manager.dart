import 'package:flutter/material.dart';
import 'package:alert_dialogs/alert_dialogs.dart';

import '../../locator.dart';
import '../models/alert/alert_request.dart';
import '../models/alert/alert_response.dart';
import '../services/dialog/dialog_service.dart';

class DialogManager extends StatefulWidget {
  final Widget child;

  const DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService;

  @override
  void initState() {
    super.initState();
    _dialogService = locator<DialogService>();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(AlertRequest request) {
    PlatformAlertDialog(
      title: request.title,
      content: request.description,
      defaultActionText: 'Ok',
      onPressed: () {
        _dialogService.dialogComplete(AlertResponse(confirmed: true));
        Navigator.of(context).pop();
      },
    ).show(context);
  }
}
