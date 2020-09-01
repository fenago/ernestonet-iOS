import 'package:flutter/material.dart';

import 'card_text_field_container_view.dart';
import 'custom_text_field_view.dart';

/// Textfield for email, name
class TextFieldView extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String placeholder;
  final int maxLength;
  final ValidatorCallback validator;

  const TextFieldView({
    Key key,
    @required this.textEditingController,
    this.textInputType,
    this.placeholder,
    this.maxLength,
    this.validator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardTextFieldContainerView(
      child: CustomTextFieldView(
        textEditingController: textEditingController,
        keyboardInputType: textInputType,
        placeholder: placeholder,
        textMaxLength: maxLength,
        validator: validator,
      ),
    );
  }
}