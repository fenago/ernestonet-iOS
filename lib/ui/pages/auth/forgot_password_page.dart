import 'package:custom_buttons/custom_buttons.dart';
import 'package:edustar/core/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/extensions/padding_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/services/auth/auth_service.dart';
import '../../../core/view_models/forgot_password_view_model.dart';
import '../../shared/ui_helper.dart';
import '../../widgets/text_fields/phone_number_text_field_view.dart';
import '../base_view.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String mobileNumber;
  ForgotPasswordPage({Key key, @required this.mobileNumber}) : super(key: key);

  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _phoneNumberTextEditingController;

  @override
  void initState() {
    super.initState();
    _phoneNumberTextEditingController = TextEditingController(text: widget.mobileNumber);
  }

  @override
  void dispose() {
    _phoneNumberTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final locale = AppLocalizations.of(context);

    return BaseView<ForgotPasswordViewModel>(
      model: ForgotPasswordViewModel(authService: context.watch<AuthService>()),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    locale.forgotPassword,
                    style: context.textTheme().headline4,
                  ),
                  SizedBox(width: 10, height: 10),
                  Text(
                    locale.forgotPasswordDesc,
                    style: context.textTheme().bodyText1.copyWith(color: Colors.grey),
                  ),
                  UIHelper.verticalSpaceMedium(),
                  Form(
                    key: _formKey,
                    child: PhoneNumberTextFieldView(
                      textEditingController: _phoneNumberTextEditingController,
                      mobileCode: Constant.defaultMobileCode,
                      validator: (_) => model.validatePhoneNumber(
                        _phoneNumberTextEditingController.text,
                      ),
                    ),
                  ),
                  SizedBox(width: 15, height: 20),
                  (model.state == ViewState.busy)
                      ? Center(child: CircularProgressIndicator())
                      : FormSubmitButton(
                          title: Constant.continueBtn,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              final success = await model.forgotPassword(_phoneNumberTextEditingController.text);
                              if (success) {
                                Navigator.pushNamed(context, ViewRoutes.resetPassword, arguments: _phoneNumberTextEditingController.text);
                              }
                            }
                          },
                        ).paddingVerticalHorizontal(20.0, 10.0)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
