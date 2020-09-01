part of custom_buttons;

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final double elevation;
  final VoidCallback onPressed;

  CustomRaisedButton({
    this.child,
    this.color,
    this.borderRadius: 2.0,
    this.height: 50.0,
    this.elevation,
    this.onPressed,
  }) : assert(borderRadius != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: RaisedButton(
        child: child,
        color: color,
        disabledColor: color,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
