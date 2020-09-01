import 'package:custom_buttons/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/extensions/padding_x.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/models/mobile_register.dart';
import '../../../core/services/auth/auth_service.dart';
import '../../../core/view_models/base_view_model.dart';
import '../../../core/view_models/register_view_model.dart';
import '../../shared/ui_helper.dart';
import '../../widgets/text_fields/password_text_field_view.dart';
import '../../widgets/text_fields/phone_number_text_field_view.dart';
import '../../widgets/text_fields/text_field_view.dart';
import '../base_view.dart';

class RegisterPage extends StatefulWidget {
  final Map<String, dynamic> numberData;

  RegisterPage({Key key, @required this.numberData}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _mobileNumberTextEditingController;
  TextEditingController _firstNameTextEditingController;
  TextEditingController _lastNameTextEditingController;
  TextEditingController _emailTextEditingController;
  TextEditingController _passwordTextEditingController;
  FocusNode nameFocus;
  FocusNode emailFocus;
  FocusNode passwordFocus;
  String get phoneNumber => widget.numberData['number'];
  String get mobileCode => widget.numberData['mobile_code'];
  String get mobileCodeId => widget.numberData['mobile_code_id'];

  @override
  void initState() {
    super.initState();
    _mobileNumberTextEditingController = TextEditingController(text: phoneNumber);
    _firstNameTextEditingController = TextEditingController(text: '');
    _lastNameTextEditingController = TextEditingController(text: '');
    _emailTextEditingController = TextEditingController(text: '');
    _passwordTextEditingController = TextEditingController(text: '');
    nameFocus = FocusNode();
    emailFocus = FocusNode();
  }

  @override
  void dispose() {
    _mobileNumberTextEditingController.dispose();
    _firstNameTextEditingController.dispose();
    _lastNameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final locale = AppLocalizations.of(context);

    return BaseView<RegisterViewModel>(
      model: RegisterViewModel(authService: context.watch<AuthService>()),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0, bottom: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        locale.register,
                        style: context.textTheme().headline4,
                      ),
                      SizedBox(width: 10, height: 10),
                      Text(
                        locale.registerDesc,
                        style: context.textTheme().bodyText1.copyWith(color: Colors.grey),
                      ),
                      UIHelper.verticalSpaceMedium(),
                      PhoneNumberTextFieldView(
                        textEditingController: _mobileNumberTextEditingController,
                        mobileCode: mobileCode,
                        isInteractionEnabled: false,
                      ),
                      UIHelper.verticalSpaceSmall(),
                      TextFieldView(
                        textEditingController: _firstNameTextEditingController,
                        placeholder: locale.firstNamePlaceholder,
                        validator: (_) => model.validateName(
                          _firstNameTextEditingController.text,
                        ),
                      ),
                      UIHelper.verticalSpaceSmall(),
                      TextFieldView(
                        textEditingController: _lastNameTextEditingController,
                        placeholder: locale.lastNamePlaceholder,
                        validator: (_) => model.validateName(
                          _lastNameTextEditingController.text,
                        ),
                      ),
                      UIHelper.verticalSpaceSmall(),
                      TextFieldView(
                        textEditingController: _emailTextEditingController,
                        placeholder: locale.emailPlaceholder,
                        textInputType: TextInputType.emailAddress,
                        validator: (_) => model.validateEmail(
                          _emailTextEditingController.text,
                        ),
                      ),
                      UIHelper.verticalSpaceSmall(),
                      PasswordTextFieldView(
                        textEditingController: _passwordTextEditingController,
                        placeholder: locale.passwordPlaceholder,
                        validator: (_) => model.validatePassword(
                          _passwordTextEditingController.text,
                        ),
                      ),
                      SizedBox(width: 10, height: 20),
                      (model.state == ViewState.busy)
                          ? Center(child: CircularProgressIndicator())
                          : FormSubmitButton(
                              title: Constant.continueBtn,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  final mobileRegister = MobileRegister(
                                    firstName: _firstNameTextEditingController.text.trim(),
                                    lastName: _lastNameTextEditingController.text.trim(),
                                    email: _emailTextEditingController.text.trim(),
                                    mobile: phoneNumber.trim(),
                                    device: 'android',
                                    mobileToken: 'xxxxxxxx',
                                    password: _passwordTextEditingController.text.trim(),
                                    countryId: mobileCodeId,
                                  );
                                  await model.registerUser(mobileRegister);
                                  if (model.state != ViewState.error) {
                                    final mobileDatas = {
                                      'phoneNumber': phoneNumber.trim(),
                                      'mobileCode': mobileCode,
                                      'mobileCodeId': mobileCodeId,
                                      'isFromProfileEdit': false,
                                    };
                                    Navigator.pushNamed(context, ViewRoutes.otp, arguments: mobileDatas);
                                  }
                                }
                              },
                            ).paddingVerticalHorizontal(20.0, 10.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
