part of alert_dialogs;

class PlatformAlertDialogAction extends PlatformAlertDialogBase {
  final Widget child;
  final VoidCallback onPressed;

  PlatformAlertDialogAction({
    this.child,
    this.onPressed,
  });

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(
      child: child,
      onPressed: onPressed,
    );
  }
}
