import 'package:custom_buttons/custom_buttons.dart';
import 'package:edustar/core/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/extensions/padding_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/services/auth/auth_service.dart';
import '../../../core/view_models/auth_view_model.dart';
import '../../../core/view_models/home_bottom_navigation_view_model.dart';
import '../../../core/view_models/otp_view_model.dart';
import '../../widgets/text_fields/text_field_view.dart';
import '../../shared/ui_helper.dart';
import '../base_view.dart';

class OtpPage extends StatefulWidget {
  final Map<String, dynamic> mobileData;

  OtpPage({
    Key key,
    @required this.mobileData,
  }) : super(key: key);

  @override
  OtpPageState createState() => OtpPageState();
}

class OtpPageState extends State<OtpPage> {
  TextEditingController _otpTextEditingController;
  String get phoneNumber => widget.mobileData['phoneNumber'];
  String get mobileCode => widget.mobileData['mobileCode'];
  String get mobileCodeId => widget.mobileData['mobileCodeId'];
  bool get isFromProfileEdit => widget.mobileData['isFromProfileEdit'];

  @override
  void initState() {
    _otpTextEditingController = TextEditingController(text: '12345');
    super.initState();
  }

  @override
  void dispose() {
    _otpTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final locale = AppLocalizations.of(context);

    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: BaseView<OtpViewModel>(
        model: OtpViewModel(authService: context.watch<AuthService>()),
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            elevation: 0.0,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        locale.otp,
                        style: context.textTheme().headline4,
                      ),
                      SizedBox(width: 10, height: 10),
                      buildInfoMessageView(context),
                      UIHelper.verticalSpaceMedium(),
                      IgnorePointer(
                        child: Form(
                          key: _formKey,
                          child: TextFieldView(
                            textEditingController: _otpTextEditingController,
                            placeholder: locale.otp,
                            maxLength: 5,
                          ),
                        ),
                      ),
                      SizedBox(width: 20, height: 30),
                      buildResendOtpView(context),
                      SizedBox(width: 15, height: 20),
                      (model.state == ViewState.busy)
                          ? Center(child: CircularProgressIndicator())
                          : FormSubmitButton(
                              title: Constant.continueBtn,
                              onPressed: () async {
                                await model.sendOtpVerification(phoneNumber, _otpTextEditingController.text, mobileCode);
                                if (model.state != ViewState.error) {
                                  if (!isFromProfileEdit) {
                                    context.read<AuthViewModel>().setAuthState(AuthState.authenticated);
                                    context.read<HomeBottomNavigationViewModel>().setBottomBarIndex(0);
                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                  } else {
                                    Navigator.pop(context);
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
      ),
    );
  }

  Future<bool> _onBackButtonPressed() async {
    Navigator.of(context).popUntil((route) => route.isFirst);
    return true;
  }

  Container buildResendOtpView(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            locale.register,
            style: context.textTheme().bodyText2.copyWith(color: Colors.grey),
          ),
          SizedBox(width: 5, height: 5),
          Container(
            width: 1,
            height: 15,
            color: Colors.grey[700],
          ),
          SizedBox(width: 5, height: 5),
          Text(
            locale.timer,
            style: TextStyle(
              color: Palette.appColor,
            ),
          ),
        ],
      ),
    );
  }

  RichText buildInfoMessageView(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return RichText(
      text: TextSpan(
        text: locale.otpDesc,
        style: context.textTheme().bodyText1.copyWith(color: Colors.grey),
        children: <TextSpan>[
          TextSpan(
            text: phoneNumber,
            style: context.textTheme().bodyText2,
          ),
        ],
      ),
    );
  }
}
