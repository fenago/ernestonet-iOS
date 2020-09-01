part of custom_buttons;

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    @required String title,
    double borderRadius = 10.0,
    VoidCallback onPressed,
  }) : super(
          child: Text(title, style: TextStyle(color: Colors.white)),
          color: Color(0xFFFF6931D),
          borderRadius: borderRadius,
          onPressed: onPressed,
        );
}
