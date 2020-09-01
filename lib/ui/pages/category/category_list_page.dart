import 'package:flutter/material.dart';

import '../../../core/constants/view_routes.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/models/main_category.dart';
import '../../shared/app_style.dart';

class CategoryListPage extends StatelessWidget {
  final List<MainCategory> categories;

  const CategoryListPage({
    Key key,
    @required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(locale.categoriesNavTitle, style: appBarTheme)),
      body: SafeArea(
        child: ListView.separated(
          itemCount: categories.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) => ListTile(
            title: Text(categories[index].title, style: context.textTheme().bodyText1),
            dense: true,
            onTap: () {
              final Map<String, dynamic> data = {
                'id': categories[index].id,
                'name': categories[index].title,
              };
              Navigator.pushNamed(context, ViewRoutes.categoryDetail, arguments: data);
            },
          ),
        ),
      ),
    );
  }
}
