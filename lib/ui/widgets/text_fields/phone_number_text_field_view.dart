import 'package:flutter/material.dart';

import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../shared/ui_helper.dart';
import 'card_text_field_container_view.dart';
import 'custom_text_field_view.dart';

class PhoneNumberTextFieldView extends StatelessWidget {
  final TextEditingController textEditingController;
  final String mobileCode;
  final VoidCallback mobileCodePressed;
  final TextInputType textInputType;
  final bool isInteractionEnabled;
  final ValidatorCallback validator;
  final EditingCallback onEditing;

  PhoneNumberTextFieldView({
    Key key,
    @required this.textEditingController,
    @required this.mobileCode,
    this.mobileCodePressed,
    this.textInputType,
    this.isInteractionEnabled = true,
    this.validator,
    this.onEditing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return CardTextFieldContainerView(
      child: Row(
        children: <Widget>[
          InkWell(
            child: Text(
              mobileCode,
              style: context.textTheme().bodyText2.copyWith(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            onTap: mobileCodePressed,
          ),
          UIHelper.horizontalSpaceSmall(),
          Expanded(
            child: IgnorePointer(
              ignoring: !isInteractionEnabled,
              child: CustomTextFieldView(
                textEditingController: textEditingController,
                keyboardInputType: TextInputType.number,
                placeholder: locale.mobileNoPlaceholder,
                validator: validator,
                onEditing: onEditing,
              ),
            ),
          ),
          UIHelper.horizontalSpaceSmall(),
          isInteractionEnabled
              ? SizedBox()
              : FlatButton(
                  child: Text(
                    'Change',
                    style: TextStyle(color: context.theme().accentColor),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
        ],
      ),
    );
  }
}
