import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:custom_buttons/custom_buttons.dart';
import 'package:edustar/core/view_models/app_language_view_model.dart';
import 'package:edustar/core/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/extensions/media_query_x.dart';
import '../../../core/extensions/padding_x.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/models/mobile_signin.dart';
import '../../../core/services/auth/auth_service.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../core/view_models/auth_view_model.dart';
import '../../../core/view_models/home_bottom_navigation_view_model.dart';
import '../../../core/view_models/login_form_view_model.dart';
import '../../../core/view_models/login_view_model.dart';
import '../../../locator.dart';
import '../../shared/ui_helper.dart';
import '../../widgets/text_fields/password_text_field_view.dart';
import '../../widgets/text_fields/phone_number_text_field_view.dart';
import '../base_view.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return BaseView<LoginViewModel>(
      model: LoginViewModel(authService: context.watch<AuthService>()),
      onModelReady: (model) async {
        await model.checkAppleSiginInAvailable();
        print('Apple SignIn : ${model.isAppleSignInAvailable}');
      },
      builder: (context, model, child) => Scaffold(
        body: GestureDetector(
          onTap: () {
            // FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: LoginContainerView(model: model, title: locale.login),
          ),
        ),
      ),
    );
  }
}

class LoginContainerView extends StatefulWidget {
  final LoginViewModel model;
  final String title;

  LoginContainerView({this.model, this.title});
  @override
  _LoginContainerViewState createState() => _LoginContainerViewState();
}

class _LoginContainerViewState extends State<LoginContainerView> {
  TextEditingController _phoneNumberTextEditingController;
  TextEditingController _passwordTextEditingController;
  final landing = locator<LocalStorageService>().landing;
  bool showPass = false;
  String mobileCode = Constant.defaultMobileCode;
  String mobileCodeId = Constant.defaultMobileCodeId;

  LoginViewModel get model => widget.model;

  @override
  void initState() {
    super.initState();
    _phoneNumberTextEditingController = TextEditingController(text: '');
    _passwordTextEditingController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _phoneNumberTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final locale = AppLocalizations.of(context);

    return BaseView<LoginFormViewModel>(
      model: LoginFormViewModel(),
      builder: (context, formModel, child) => Container(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      AssetImages.appLogo,
                      width: context.mediaQuerySize().width / 1.5,
                      height: context.mediaQuerySize().height / 4,
                    ),
                  ),
                  UIHelper.verticalSpaceMedium(),
                  Text(
                    widget.title,
                    style: context.textTheme().headline4,
                  ),
                  UIHelper.verticalSpaceMedium(),
                  Text(
                    locale.phoneNumberDesc,
                    style: context.textTheme().bodyText1.copyWith(color: Colors.grey),
                  ),
                  UIHelper.verticalSpaceLarge(),
                  PhoneNumberTextFieldView(
                    textEditingController: _phoneNumberTextEditingController,
                    mobileCode: mobileCode,
                    validator: (_) => model.validatePhoneNumber(
                      _phoneNumberTextEditingController.text,
                    ),
                    mobileCodePressed: _showMobileCodes,
                    onEditing: (_) => formModel.onEditingField(_phoneNumberTextEditingController.text),
                  ),
                  UIHelper.verticalSpaceMedium(),
                  _buildPasswordView(locale, model, formModel),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      child: Text(
                        locale.forgotPasswordLbl,
                        style: TextStyle(color: Palette.appColor),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, ViewRoutes.forgotPassword, arguments: _phoneNumberTextEditingController.text);
                      },
                    ),
                  ),
                  UIHelper.verticalSpaceExtraSmall(),
                  (model.state == ViewState.busy)
                      ? Center(
                          child: Column(
                            children: <Widget>[
                              CircularProgressIndicator(),
                              UIHelper.verticalSpaceMedium(),
                            ],
                          ),
                        )
                      : FormSubmitButton(
                          title: Constant.continueBtn,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              if (model.userExist && model.isPhoneNumberVerified) {
                                final mobileSignIn = MobileSignIn(
                                  mobile: _phoneNumberTextEditingController.text.trim(),
                                  password: _passwordTextEditingController.text.trim(),
                                  role: 'user',
                                  device: 'android',
                                  mobileToken: 'xxxxxxxx',
                                  countryId: mobileCodeId,
                                );
                                await model.loginWithPhoneNumber(mobileSignIn);
                                if (model.state != ViewState.error) {
                                  locator<LocalStorageService>().loggedIn = true;
                                  context.read<AuthViewModel>().setAuthState(AuthState.authenticated);
                                  context.read<HomeBottomNavigationViewModel>().setBottomBarIndex(0);
                                }
                              } else {
                                await model.checkUserExists(_phoneNumberTextEditingController.text);
                                if (!model.userExist) {
                                  final numberData = {
                                    'number': _phoneNumberTextEditingController.text,
                                    'mobile_code': mobileCode,
                                    'mobile_code_id': mobileCodeId,
                                  };
                                  Navigator.pushNamed(
                                    context,
                                    ViewRoutes.register,
                                    arguments: numberData,
                                  );
                                } else if (!model.isPhoneNumberVerified) {
                                  final mobileDatas = {
                                    'phoneNumber': _phoneNumberTextEditingController.text.trim(),
                                    'mobileCode': mobileCode,
                                    'mobileCodeId': mobileCodeId,
                                    'isFromProfileEdit': false,
                                  };
                                  Navigator.pushNamed(
                                    context,
                                    ViewRoutes.otp,
                                    arguments: mobileDatas,
                                  );
                                }
                              }
                            }
                          },
                        ).paddingVerticalHorizontal(20.0, 10.0),
                  if (landing.social.google) LoginFooterView(buildContext: context, model: model)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileCodes() {
    final mobileCodes = locator<LocalStorageService>().landing.country;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(15.0),
              height: 40.0,
              child: Text('Select Country Code', style: context.textTheme().headline6.copyWith(fontSize: 18.0)),
            ),
            Flexible(
              child: ListView.separated(
                itemCount: mobileCodes.length,
                shrinkWrap: true,
                separatorBuilder: (context, _) => Divider(),
                itemBuilder: (context, index) => ListTile(
                  dense: true,
                  leading: Text('+${mobileCodes[index].phonecode}', style: context.textTheme().headline6.copyWith(fontSize: 16.0)),
                  title: Text('${mobileCodes[index].name}', style: context.textTheme().headline6.copyWith(fontSize: 16.0)),
                  onTap: () {
                    setState(() {
                      mobileCode = '+${mobileCodes[index].phonecode}';
                      mobileCodeId = '${mobileCodes[index].id}';
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPasswordView(AppLocalizations locale, LoginViewModel loginModel, LoginFormViewModel formModel) {
    print('USER Exists : ${model.userExist}');
    print('Ph Verified : ${model.isPhoneNumberVerified}');
    print('10 digit ? : ${formModel.showPassword}');
    if (!formModel.showPassword) {
      loginModel.userExist = false;
      loginModel.isPhoneNumberVerified = false;
    }
    if (loginModel.userExist && loginModel.isPhoneNumberVerified && formModel.showPassword) {
      return PasswordTextFieldView(
        textEditingController: _passwordTextEditingController,
        placeholder: locale.passwordPlaceholder,
        validator: (_) => loginModel.validatePassword(
          _passwordTextEditingController.text,
        ),
      );
    } else {
      return SizedBox();
    }
  }
}

class LoginFooterView extends StatefulWidget {
  final LoginViewModel model;
  final BuildContext buildContext;

  const LoginFooterView({Key key, @required this.buildContext, @required this.model}) : super(key: key);

  @override
  _LoginFooterViewState createState() => _LoginFooterViewState();
}

class _LoginFooterViewState extends State<LoginFooterView> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 1.0,
                  color: Colors.grey[400],
                ),
              ),
              Text(locale.orLoginWith).paddingHorizontal(15.0),
              Expanded(
                child: Container(
                  height: 1.0,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
          SocialAuthButton(
            title: Constant.signInWithGoogle,
            onPressed: () async {
              await widget.model.signInWithGoogle();
              widget.buildContext.read<AuthViewModel>().setAuthState(AuthState.authenticated);
              widget.buildContext.read<HomeBottomNavigationViewModel>().setBottomBarIndex(0);
            },
          ).paddingVerticalHorizontal(20.0, 10.0),
          // if (widget.model.isAppleSignInAvailable)
          //   AppleSignInButton(
          //     style: ButtonStyle.black,
          //     type: ButtonType.signIn,
          //     cornerRadius: 30.0,
          //     onPressed: () async {
          //       await widget.model.signInWithApple();
          //       final email = widget.model.email;
          //       print('Apple User Email : $email');
          //       if (email != null) {
          //         widget.buildContext.read<AuthViewModel>().setAuthState(AuthState.authenticated);
          //         widget.buildContext.read<HomeBottomNavigationViewModel>().setBottomBarIndex(0);
          //       }
          //     },
          //   ).paddingVerticalHorizontal(20.0, 10.0),
        ],
      ),
    );
  }
}
