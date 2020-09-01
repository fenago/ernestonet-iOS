import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:edustar/core/constants/api_routes.dart';
import 'package:edustar/core/view_models/privacy_terms_about_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/data_sources/course_category_data_source.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/models/user.dart';
import '../../../core/repositories/user/user_repository.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../core/view_models/auth_view_model.dart';
import '../../../core/view_models/base_view_model.dart';
import '../../../core/view_models/cart_badge_view_model.dart';
import '../../../core/view_models/profile_view_model.dart';
import '../../../locator.dart';
import '../../shared/ui_helper.dart';
import '../../widgets/initial_circle_avatar.dart';
import '../../widgets/list_row_item.dart';
import '../../widgets/progress_child_container.dart';
import '../base_view.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      model: ProfileViewModel(userRepository: UserRepository()),
      onModelReady: (model) => model.fetchUserProfile(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: ProgressChildContainer(
            busy: (model.state == ViewState.busy),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      UIHelper.verticalSpaceMedium(),
                      ProfileHeaderView(),
                      SizedBox(height: 30.0),
                      MenuRootView(model: model),
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

class ProfileHeaderView extends StatefulWidget {
  ProfileHeaderView({Key key}) : super(key: key);

  @override
  _ProfileHeaderViewState createState() => _ProfileHeaderViewState();
}

class _ProfileHeaderViewState extends State<ProfileHeaderView> {
  User user = locator<LocalStorageService>().user;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final localStorageService = locator<LocalStorageService>();

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            locale.hello,
            style: context.textTheme().headline5.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey[200],
                ),
          ),
          SizedBox(height: 10.0),
          Text(
            user.name.isEmpty ? user.firstName + ' ' + user.lastName : user.name,
            style: context.textTheme().headline4,
          ),
          SizedBox(height: 10.0),
          InkWell(
            onTap: () async {
              final editProfilePopped = await Navigator.pushNamed(context, ViewRoutes.profileEdit, arguments: user);
              if (editProfilePopped) {
                setState(() {
                  user = localStorageService.user;
                });
              }
            },
            child: Row(
              children: <Widget>[
                Container(
                  height: 80.0,
                  width: 80.0,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.theme().primaryColor,
                    boxShadow: localStorageService.darkMode
                        ? []
                        : [
                            BoxShadow(
                              offset: Offset(3, 3),
                              color: Colors.black12,
                              blurRadius: 5,
                            ),
                            BoxShadow(
                              offset: Offset(-3, -3),
                              color: Colors.white,
                              blurRadius: 5,
                            ),
                          ],
                  ),
                  child: Hero(
                    tag: 'profileHero',
                    child: user?.userImg == ''
                        ? InitialCircleAvatar(name: user.name.isEmpty ? user.firstName + user.lastName : user.name)
                        : ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: (user?.userImg != '') ? user.userImg : AssetImages.course,
                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                              fit: BoxFit.fill,
                            ),
                          ),
                  ),
                ),
                SizedBox(width: 15.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      (user != null) ? user.mobile : '',
                      style: context.textTheme().bodyText1,
                    ),
                    UIHelper.verticalSpaceSmall(),
                    Text(
                      (user != null) ? user.email : '',
                      maxLines: 1,
                      style: context.textTheme().bodyText1,
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.edit, size: 20),
                UIHelper.horizontalSpaceSmall(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuRootView extends StatelessWidget {
  final ProfileViewModel model;

  const MenuRootView({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AccountMenuView(
          locale: locale,
          accountMenus: [
            locale.displayMode,
            locale.changeLanguage,
          ],
          icons: [
            Icons.palette,
            Icons.language,
          ],
        ),
        UIHelper.verticalSpaceSmall(),
        GeneralMenuView(model: model, locale: locale, generalMenus: [
          locale.inviteFriends,
          locale.privacyPolicy,
          locale.termsOfService,
          // locale.rateEduStar,
          // locale.help,
          locale.about,
          locale.signout,
        ], icons: [
          Icons.people,
          Icons.security,
          Icons.description,
          // Icons.rate_review,
          // Icons.help,
          Icons.info,
          Icons.exit_to_app,
        ]),
      ],
    );
  }
}

class AccountMenuView extends StatelessWidget {
  final AppLocalizations locale;
  final List<String> accountMenus;
  final List<IconData> icons;

  AccountMenuView({
    Key key,
    @required this.locale,
    @required this.accountMenus,
    @required this.icons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          locale.account,
          style: context.textTheme().subtitle2.copyWith(fontWeight: FontWeight.w600),
        ),
        UIHelper.verticalSpaceMedium(),
        Column(
          children: List.generate(
            accountMenus.length,
            (index) => ListRowItem(
              accountName: accountMenus[index],
              icon: icons[index],
              listRowHandler: () {
                if (index == 0) {
                  Navigator.pushNamed(context, ViewRoutes.chooseDisplayMode);
                } else if (index == 1) {
                  Navigator.pushNamed(context, ViewRoutes.chooseLanguage);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

class GeneralMenuView extends StatelessWidget {
  final ProfileViewModel model;
  final AppLocalizations locale;
  final List<String> generalMenus;
  final List<IconData> icons;

  GeneralMenuView({
    Key key,
    @required this.model,
    @required this.locale,
    @required this.generalMenus,
    @required this.icons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          locale.general,
          style: context.textTheme().subtitle2.copyWith(fontWeight: FontWeight.w600),
        ),
        UIHelper.verticalSpaceMedium(),
        Column(
          children: List.generate(
            generalMenus.length,
            (index) => ListRowItem(
              accountName: generalMenus[index],
              icon: icons[index],
              listRowHandler: () async {
                switch (index) {
                  case 0:
                    Navigator.pushNamed(context, ViewRoutes.inviteFriends);
                    break;
                  case 1:
                    if (Platform.isIOS) {
                      _openInlineBrowser(AppDetail.privacy);
                    } else {
                      Navigator.pushNamed(context, ViewRoutes.privacyAboutTerms, arguments: AppDetail.privacy);
                    }
                    break;
                  case 2:
                    if (Platform.isIOS) {
                      _openInlineBrowser(AppDetail.terms);
                    } else {
                      Navigator.pushNamed(context, ViewRoutes.privacyAboutTerms, arguments: AppDetail.terms);
                    }
                    break;
                  // case 3:
                  //   _openRateEdustar();
                  //   break;
                  // case 4:
                  //   launch("tel://8870123456");
                  //   break;
                  case 3:
                    if (Platform.isIOS) {
                      _openInlineBrowser(AppDetail.about);
                    } else {
                      Navigator.pushNamed(context, ViewRoutes.privacyAboutTerms, arguments: AppDetail.about);
                    }
                    break;
                  case 4:
                    final googleSignIn = GoogleSignIn();
                    await googleSignIn.signOut();
                    locator<LocalStorageService>().loggedIn = false;
                    locator<CourseCategoryDataSource>().deleteAllHiveBox();
                    context.read<CartBadgeViewModel>().updateCartCourseCount(0);
                    context.read<AuthViewModel>().setAuthState(AuthState.unauthenticated);
                    break;
                  default:
                    print('Unknown Item Tapped');
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  void _openInlineBrowser(AppDetail appDetail) async {
    final url = getURL(appDetail);
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, forceSafariVC: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  String getURL(AppDetail appDetail) {
    switch (appDetail) {
      case AppDetail.terms:
        return ApiRoutes.termsOfServices;
      case AppDetail.privacy:
        return ApiRoutes.privacy;
      default:
        return ApiRoutes.about;
    }
  }
}
