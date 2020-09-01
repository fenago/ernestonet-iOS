import 'package:flutter/material.dart';

import 'card_text_field_container_view.dart';
import 'custom_text_field_view.dart';

/// Textfield for password
class PasswordTextFieldView extends StatefulWidget {
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String placeholder;
  final ValidatorCallback validator;

  PasswordTextFieldView({
    Key key,
    @required this.textEditingController,
    @required this.placeholder,
    this.textInputType,
    this.validator,
  }) : super(key: key);

  @override
  _PasswordTextFieldViewState createState() => _PasswordTextFieldViewState();
}

class _PasswordTextFieldViewState extends State<PasswordTextFieldView> {
  bool showPasswordText = false;

  @override
  Widget build(BuildContext context) {
    return CardTextFieldContainerView(
      child: Row(
        children: <Widget>[
          Expanded(
            child: CustomTextFieldView(
              textEditingController: widget.textEditingController,
              keyboardInputType: widget.textInputType,
              isSecureText: !showPasswordText,
              placeholder: widget.placeholder,
              validator: widget.validator,
            ),
          ),
          IconButton(
            icon: showPasswordText
                ? Icon(Icons.visibility, color: Colors.black)
                : Icon(Icons.visibility_off, color: Colors.black),
            onPressed: () =>
                setState(() => showPasswordText = !showPasswordText),
          ),
        ],
      ),
    );
  }
}
