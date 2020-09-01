import 'package:custom_buttons/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import '../../../core/extensions/padding_x.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/services/auth/auth_service.dart';
import '../../../core/view_models/base_view_model.dart';
import '../../../core/view_models/reset_password_view_model.dart';
import '../../shared/ui_helper.dart';
import '../../widgets/text_fields/password_text_field_view.dart';
import '../base_view.dart';

class ResetPasswordPage extends StatefulWidget {
  final String phoneNumber;
  ResetPasswordPage({Key key, @required this.phoneNumber}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController _passwordTextEditingController;
  TextEditingController _confirmPasswordTextEditingController;
  FocusNode passwordFocus;
  FocusNode confirmPasswordFocus;

  @override
  void initState() {
    super.initState();
    _passwordTextEditingController = TextEditingController();
    _confirmPasswordTextEditingController = TextEditingController();
    passwordFocus = FocusNode();
    confirmPasswordFocus = FocusNode();
  }

  @override
  void dispose() {
    _passwordTextEditingController.dispose();
    _confirmPasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final locale = AppLocalizations.of(context);

    return BaseView<ResetPasswordViewModel>(
      model: ResetPasswordViewModel(authService: context.watch<AuthService>()),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      locale.resetPassword,
                      style: context.textTheme().headline4,
                    ),
                    UIHelper.verticalSpaceMedium(),
                    PasswordTextFieldView(
                      textEditingController: _passwordTextEditingController,
                      placeholder: locale.passwordPlaceholder,
                      validator: (_) => model.validatePassword(
                        _passwordTextEditingController.text,
                      ),
                    ),
                    UIHelper.verticalSpaceMedium(),
                    PasswordTextFieldView(
                      textEditingController: _confirmPasswordTextEditingController,
                      placeholder: locale.confirmPasswordPlaceholder,
                      validator: (_) => model.validatePassword(
                        _passwordTextEditingController.text,
                      ),
                    ),
                    UIHelper.verticalSpaceMedium(),
                    (model.state == ViewState.busy)
                        ? Center(child: CircularProgressIndicator())
                        : FormSubmitButton(
                            title: Constant.continueBtn,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await model.resetPassword(
                                  _passwordTextEditingController.text,
                                  _confirmPasswordTextEditingController.text,
                                  widget.phoneNumber,
                                );
                                if (model.state != ViewState.error) {
                                  print('Password reset successfully');
                                  Navigator.of(context).popUntil((route) => route.isFirst);
                                } else {
                                  print('Failed to reset password');
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
      ),
    );
  }
}
