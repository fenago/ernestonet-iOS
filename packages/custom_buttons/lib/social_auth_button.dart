part of custom_buttons;

class SocialAuthButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const SocialAuthButton({
    Key key,
    @required this.title,
    @required this.onPressed,
  })  : assert(title != ''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.only(left: 0, top: 12, right: 10, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/google_icon.png',
              height: 20.0,
              width: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey[600], fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
