part of alert_dialogs;

class PlatformAlertDialog extends PlatformAlertDialogBase {
  final String title;
  final String content;
  final String defaultActionText;
  final String cancelActionText;
  final VoidCallback onPressed;

  PlatformAlertDialog({
    @required this.title,
    @required this.content,
    @required this.defaultActionText,
    @required this.onPressed,
    this.cancelActionText,
  })  : assert(content != ''),
        assert(defaultActionText != '');

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context,
            builder: (context) => this,
          )
        : await showDialog<bool>(
            context: context,
            barrierDismissible: true,
            builder: (context) => this,
          );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Text(
        content,
        style: GoogleFonts.montserrat(
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: (title != null)
          ? Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            )
          : null,
      content: Text(
        content,
        style: GoogleFonts.montserrat(
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final actions = <Widget>[];
    if (cancelActionText != null) {
      actions.add(
        PlatformAlertDialogAction(
          child: Text(cancelActionText),
          onPressed: onPressed,
        ),
      );
    }
    actions.add(
      PlatformAlertDialogAction(
        child: Text(defaultActionText),
        onPressed: onPressed,
      ),
    );
    return actions;
  }
}
