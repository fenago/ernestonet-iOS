import 'package:custom_buttons/custom_buttons.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/constants/asset_images.dart';
import '../../../core/extensions/media_query_x.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/share_helper.dart' as share_helper;
import '../../shared/ui_helper.dart';

class InviteFriendsPage extends StatefulWidget {
  @override
  _InviteFriendsPageState createState() => _InviteFriendsPageState();
}

class _InviteFriendsPageState extends State<InviteFriendsPage> {
  TextEditingController codeTextEditingController;
  @override
  void initState() {
    super.initState();
    codeTextEditingController = TextEditingController(text: 'MARTHA034');
  }

  @override
  void dispose() {
    codeTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(locale.inviteFriendsNavTitle, textAlign: TextAlign.center, style: context.textTheme().headline4),
                    UIHelper.verticalSpaceMedium(),
                    Text(
                      locale.inviteFriendsHeading,
                      style: context.textTheme().subtitle1,
                    ),
                    UIHelper.verticalSpaceMedium(),
                    Image.asset(AssetImages.refer, height: context.mediaQuerySize().width / 1.2, width: context.mediaQuerySize().width / 1),
                    UIHelper.verticalSpaceMedium(),
                    Text(locale.inviteFriendsSubtitle, textAlign: TextAlign.center, style: context.textTheme().bodyText1.copyWith(color: Colors.grey, fontSize: 17.0)),
                    UIHelper.verticalSpaceExtraLarge(),
                    FormSubmitButton(
                      title: locale.inviteFriendsNow,
                      onPressed: () {
                        share_helper.share(context, Constant.inviteFriendsNow);
                      },
                    ),
                    UIHelper.verticalSpaceMedium(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
