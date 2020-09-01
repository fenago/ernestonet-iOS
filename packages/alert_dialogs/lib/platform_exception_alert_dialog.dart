
part of alert_dialogs;

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
  }) : super(
    title: title,
    content: _message(exception),
    defaultActionText: 'OK',
    onPressed: () {},
  );

  static String _message(PlatformException exception) {
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {
    'BAD_ACCESS': 'Unknown Access',
    'UNAUTHORIZED': 'Unauthorized User',
  };

}