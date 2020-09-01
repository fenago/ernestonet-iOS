import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_buttons/custom_buttons.dart';
import 'package:edustar/core/services/auth/auth_service.dart';
import 'package:edustar/core/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/models/user.dart';
import '../../../core/repositories/user/user_repository.dart';
import '../../../core/view_models/base_view_model.dart';
import '../../../core/view_models/profile_edit_view_model.dart';
import '../../../locator.dart';
import '../../shared/app_style.dart';
import '../../shared/ui_helper.dart';
import '../../widgets/initial_circle_avatar.dart';
import '../../widgets/text_fields/phone_number_text_field_view.dart';
import '../../widgets/text_fields/text_field_view.dart';
import '../base_view.dart';

class ProfileEditPage extends StatefulWidget {
  final User user;

  const ProfileEditPage({Key key, @required this.user}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final ImagePicker _imagePicker = ImagePicker();
  File selectedImage;
  String mobileCode = Constant.defaultMobileCode;
  String mobileCodeId = Constant.defaultMobileCodeId;

  TextEditingController _firstNameTextEditingController;
  TextEditingController _lastNameTextEditingController;
  TextEditingController _emailTextEditingController;
  TextEditingController _mobileNumberTextEditingController;

  @override
  void initState() {
    super.initState();
    _firstNameTextEditingController = TextEditingController(text: widget.user?.firstName ?? '');
    _lastNameTextEditingController = TextEditingController(text: widget.user?.lastName ?? '');
    _emailTextEditingController = TextEditingController(text: widget.user?.email ?? '');
    _mobileNumberTextEditingController = TextEditingController(text: widget.user?.mobile ?? '');
    mobileCode = widget.user?.countryCode;
    mobileCodeId = widget.user?.countryId.toString();
  }

  @override
  void dispose() {
    _firstNameTextEditingController.dispose();
    _lastNameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _mobileNumberTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final locale = AppLocalizations.of(context);

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
        return Future.value(false);
      },
      child: BaseView<ProfileEditViewModel>(
        model: ProfileEditViewModel(userRepository: UserRepository()),
        onModelReady: (model) => model.getInitialData(context.read<AuthService>()),
        builder: (context, model, child) => Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(locale.editProfileNavTitle, style: appBarTheme),
          ),
          body: Container(
            margin: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'profileHero',
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          _imageSelectionBottomSheet();
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 10.0),
                          color: context.theme().scaffoldBackgroundColor,
                          child: Stack(
                            children: <Widget>[
                              (selectedImage == null)
                                  ? (widget.user?.userImg == '')
                                      ? InitialCircleAvatar(name: widget.user.name.isEmpty ? widget.user.firstName + widget.user.lastName : widget.user.name)
                                      : ClipOval(
                                          child: SizedBox(
                                            width: 120.0,
                                            height: 120.0,
                                            child: CachedNetworkImage(
                                              imageUrl: (widget.user.userImg != null) ? widget.user.userImg ?? '' : AssetImages.course,
                                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                  : ClipOval(
                                      child: Image.file(
                                        selectedImage,
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                              Positioned(
                                right: 5.0,
                                bottom: 5.0,
                                child: ClipOval(
                                  child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    color: Palette.appColor,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  UIHelper.verticalSpaceMedium(),
                  TextFieldView(
                    textEditingController: _firstNameTextEditingController,
                    placeholder: locale.firstNamePlaceholder,
                  ),
                  UIHelper.verticalSpaceSmall(),
                  TextFieldView(
                    textEditingController: _lastNameTextEditingController,
                    placeholder: locale.lastNamePlaceholder,
                  ),
                  UIHelper.verticalSpaceSmall(),
                  TextFieldView(
                    textEditingController: _emailTextEditingController,
                    placeholder: locale.emailPlaceholder,
                    textInputType: TextInputType.emailAddress,
                  ),
                  UIHelper.verticalSpaceSmall(),
                  PhoneNumberTextFieldView(
                    textEditingController: _mobileNumberTextEditingController,
                    mobileCode: mobileCode.isEmpty ? Constant.defaultMobileCode : mobileCode,
                    validator: (_) => model.validatePhoneNumber(
                      _mobileNumberTextEditingController.text,
                    ),
                    mobileCodePressed: _showMobileCodes,
                  ),
                  UIHelper.verticalSpaceLarge(),
                  (model.state == ViewState.busy)
                      ? CircularProgressIndicator()
                      : FormSubmitButton(
                          title: 'UPDATE',
                          onPressed: () async {
                            final user = User(
                              id: widget.user.id,
                              firstName: _firstNameTextEditingController.text,
                              lastName: _lastNameTextEditingController.text,
                              name: _firstNameTextEditingController.text + ' ' + _lastNameTextEditingController.text,
                              email: _emailTextEditingController.text,
                              mobile: _mobileNumberTextEditingController.text,
                              countryId: int.parse(mobileCodeId),
                              countryCode: mobileCode,
                              isNew: ((widget.user.mobile.isEmpty || widget.user.mobile == null) && _mobileNumberTextEditingController.text.isNotEmpty) ? 1 : 0,
                            );
                            final isUpdated = await model.updateUserProfile(user, selectedImage);

                            if (isUpdated) {
                              if (widget.user.mobile.isEmpty || widget.user.mobile == null) {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Profile updated successfully')));
                                final mobileDatas = {
                                  'phoneNumber': _mobileNumberTextEditingController.text.trim(),
                                  'mobileCode': mobileCode,
                                  'mobileCodeId': mobileCodeId,
                                  'isFromProfileEdit': true,
                                };
                                Navigator.pushNamed(context, ViewRoutes.otp, arguments: mobileDatas);
                              } else {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Profile updated successfully')));
                              }
                            } else {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Failed to update profile')));
                            }
                          }),
                  SizedBox(height: 20.0),
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

  void _imageSelectionBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text(
                  'Camera',
                  style: context.textTheme().bodyText2.copyWith(
                        fontSize: 17.0,
                      ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text(
                  'Photo Gallery',
                  style: context.textTheme().bodyText2.copyWith(
                        fontSize: 17.0,
                      ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery);
                },
              ),
            ],
          );
        });
  }

  Future getImage(ImageSource imageSource) async {
    final pickedFile = await _imagePicker.getImage(source: imageSource, imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0);
    setState(() {
      selectedImage = File(pickedFile.path);
    });
  }
}
