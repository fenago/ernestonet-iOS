import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/extensions/padding_x.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/models/main_category.dart';
import '../../../core/repositories/course/course_repository.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../core/view_models/cart_badge_view_model.dart';
import '../../../core/view_models/home_view_model.dart';
import '../../../locator.dart';
import '../../shared/ui_helper.dart';
import '../../widgets/cart_badge_icon.dart';
import '../../widgets/course/course_large_list.dart';
import '../../widgets/course/course_small_list.dart';
import '../base_view.dart';
import 'home_shimmer_page.dart';

class HomePage extends StatefulWidget {
  final List productImages = [
    AssetImage(AssetImages.ill1),
    AssetImage(AssetImages.ill2),
    AssetImage(AssetImages.ill3),
    AssetImage(AssetImages.ill3),
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchData;

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      model: HomeViewModel(courseRepository: CourseRepository()),
      onModelReady: (model) async {
        await model.getCategoryBanner();
        await model.getAllCourses();
        await model.getCartCourses();
      },
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: (model.categoryBanner?.categories == null || model.courseCategories == null)
              ? HomeShimmerPage()
              : Column(
                  children: <Widget>[
                    _buildAppBar(context),
                    Expanded(
                      child: SingleChildScrollView(
                        child: buildCategory(model).paddingHorizontal(10.0),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Column buildCategory(HomeViewModel model) {
    final locale = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        UIHelper.verticalSpaceSmall(),
        Text(
          locale.homeTitle,
          style: context.textTheme().headline4,
        ),
        UIHelper.verticalSpaceMedium(),
        _buildSwiper(model),
        CategoriesView(
          categories: model.categoryBanner.categories,
        ),
        buildListOfCoursesView(model)
      ],
    );
  }

  Container buildListOfCoursesView(HomeViewModel model) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: (model.courseCategories != null) ? model.courseCategories.length : 0,
              itemBuilder: (context, index) {
                if (index % 2 == 0) {
                  return CourseSmallList(
                    courseCategory: model.courseCategories[index],
                  );
                } else {
                  return CourseLargeList(courseCategory: model.courseCategories[index]);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Row _buildAppBar(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
            padding: EdgeInsets.all(10.0),
            height: 50.0,
            decoration: BoxDecoration(
              color: context.theme().scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(2.0),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.6), spreadRadius: 1, blurRadius: 6, offset: Offset(0, 2)),
              ],
            ),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, ViewRoutes.searchCourse),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.search,
                    color: Colors.grey[700],
                  ),
                  UIHelper.horizontalSpaceSmall(),
                  Text(locale.searchPlaceholder, style: context.textTheme().subtitle1.copyWith(color: Colors.grey[700])),
                ],
              ),
            ),
          ),
        ),
        CartBadgeIcon(
          onPressed: () async {
            final isPopped = await Navigator.pushNamed(context, ViewRoutes.cart);
            if (isPopped) {
              await context.read<CartBadgeViewModel>().getCartCourses();
              await context.read<HomeViewModel>().getCategoryBanner();
              await context.read<HomeViewModel>().getAllCourses();
            }
          },
        ),
        UIHelper.horizontalSpaceExtraSmall(),
      ],
    );
  }

  Container _buildSwiper(HomeViewModel model) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 200,
        width: double.infinity,
        child: Swiper(
          itemHeight: 100,
          duration: 500,
          itemWidth: double.infinity,
          pagination: SwiperPagination(),
          itemBuilder: (BuildContext context, int index) {
            return CachedNetworkImage(
              imageUrl: (model.categoryBanner.sliders[index]?.image != null) ? model.categoryBanner.sliders[index].image : AssetImages.course,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
            );
          },
          itemCount: model.categoryBanner.sliders.length,
          autoplay: true,
          viewportFraction: 1.0,
          scale: 0.9,
        ),
      );
}

class CategoriesView extends StatelessWidget {
  final List<MainCategory> categories;
  final List<List<MainCategory>> splittedCategories = [];

  CategoriesView({Key key, @required this.categories}) : super(key: key);

  void generateCategories() {
    var len = categories.length;
    var size = 4;

    for (var i = 0; i < len; i += size) {
      var end = (i + size < len) ? i + size : len;
      splittedCategories.add(categories.sublist(i, end));
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final localStorageService = locator<LocalStorageService>();
    generateCategories();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                locale.categories,
                style: context.textTheme().subtitle1.copyWith(fontSize: 17.0, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              FlatButton(
                child: Text(
                  locale.seeAll,
                  style: context.textTheme().subtitle2.copyWith(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, ViewRoutes.categoryList, arguments: categories);
                },
              )
            ],
          ),
          Flexible(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getCategoryChips(
                  context,
                  splittedCategories[0],
                  localStorageService,
                ),
                if (categories.length > 4 || categories.length < 9)
                  getCategoryChips(
                    context,
                    splittedCategories[1],
                    localStorageService,
                  ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Row getCategoryChips(BuildContext context, List<MainCategory> categories, LocalStorageService localStorageService) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        categories.length,
        (index) => InkWell(
          onTap: () {
            final Map<String, dynamic> data = {
              'id': categories[index].id,
              'name': categories[index].title,
            };
            Navigator.pushNamed(context, ViewRoutes.categoryDetail, arguments: data);
          },
          child: Chip(
            backgroundColor: Colors.grey[200],
            labelPadding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
            avatar: Icon(
              Icons.business,
              size: 15.0,
              color: localStorageService.darkMode ? Colors.grey[800] : Colors.black,
            ),
            label: Text(
              categories[index].title,
              style: context.textTheme().bodyText2.copyWith(
                    fontSize: 12.0,
                    color: localStorageService.darkMode ? Colors.grey[800] : Colors.black,
                  ),
            ),
            labelStyle: context.textTheme().bodyText2.copyWith(fontSize: 12.0),
            padding: const EdgeInsets.only(right: 10.0),
          ).paddingHorizontal(8.0),
        ),
      ),
    );
  }
}
