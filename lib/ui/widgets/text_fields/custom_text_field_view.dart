import 'package:flutter/material.dart';

import '../../../core/extensions/theme_x.dart';

typedef ValidatorCallback = String Function(String);
typedef EditingCallback = void Function(String);

class CustomTextFieldView extends StatelessWidget {
  final TextInputAction keyboardButton;
  final TextInputType keyboardInputType;
  final TextEditingController textEditingController;
  final FocusNode submitedFocusNode;
  final int textMaxLength;
  final String placeholder;
  final String defaultText;
  final bool isSecureText;
  final ValidatorCallback validator;
  final EditingCallback onEditing;

  const CustomTextFieldView({
    Key key,
    @required this.textEditingController,
    this.keyboardButton = TextInputAction.done,
    this.keyboardInputType = TextInputType.text,
    this.submitedFocusNode,
    this.textMaxLength = 50,
    this.placeholder,
    this.defaultText,
    this.isSecureText = false,
    this.validator,
    this.onEditing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: keyboardButton,
      keyboardType: keyboardInputType,
      controller: textEditingController,
      maxLength: textMaxLength,
      obscureText: isSecureText,
      validator: validator,
      onChanged: onEditing,
      style: context.textTheme().bodyText2.copyWith(fontSize: 15.0, color: Colors.black),
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(submitedFocusNode);
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: placeholder,
        hintStyle: TextStyle(color: Colors.grey[400]),
        counterText: '',
        contentPadding: EdgeInsets.only(top: 1.0),
      ),
    );
  }
}
