import 'package:custom_buttons/custom_buttons.dart';
import 'package:edustar/core/services/local_storage_service.dart';
import 'package:edustar/core/view_models/base_view_model.dart';
import 'package:edustar/locator.dart';
import 'package:edustar/ui/widgets/progress_child_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/extensions/media_query_x.dart';
import '../../../core/extensions/padding_x.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/models/course/course.dart';
import '../../../core/repositories/course/course_repository.dart';
import '../../../core/view_models/cart_badge_view_model.dart';
import '../../../core/view_models/cart_view_model.dart';
import '../../widgets/course/cart_course_item.dart';
import '../../shared/ui_helper.dart';
import '../../shared/app_style.dart';
import '../base_view.dart';

class CartPage extends StatefulWidget {
  final Course course;

  const CartPage({Key key, this.course}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<Course> courses = [];
  Course get courseDetailCourse => widget.course;

  @override
  Widget build(BuildContext context) {
    final localStorageService = locator<LocalStorageService>();
    final locale = AppLocalizations.of(context);

    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: BaseView<CartViewModel>(
        model: CartViewModel(courseRepository: CourseRepository()),
        onModelReady: (model) => model.getCartCourses(),
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(locale.cartNavTitle, style: appBarTheme),
          ),
          body: SafeArea(
            child: model.state == ViewState.busy
                ? Center(child: ProgressChildContainer(child: CircularProgressIndicator()))
                : Container(
                    alignment: model.cartCourses.isEmpty ? Alignment.center : Alignment.topLeft,
                    margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    child: model.cartCourses.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(AssetImages.emptyCart, width: context.mediaQuerySize().width / 1, height: context.mediaQuerySize().width / 2),
                              UIHelper.verticalSpaceLarge(),
                              Text('No Courses', style: context.textTheme().headline6.copyWith(fontWeight: FontWeight.w400)),
                            ],
                          )
                        : Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: _CartView(
                                    cartViewModel: model,
                                    courseDetailCourse: courseDetailCourse,
                                  ),
                                ),
                              ),
                              if (model.cartCourses.isNotEmpty)
                                CustomRaisedButton(
                                  borderRadius: 0.0,
                                  child: Text(locale.buyNow, style: TextStyle(color: Colors.white)),
                                  color: localStorageService.darkMode ? Palette.appColor : Colors.black,
                                  onPressed: () => Navigator.pushNamed(context, ViewRoutes.paymentSelection, arguments: model.cartCourses),
                                ).paddingVertical(20.0)
                            ],
                          ),
                  ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackButtonPressed() async {
    Navigator.pop(context, true);
    return Future.value(true);
  }
}

class _CartView extends StatelessWidget {
  final CartViewModel cartViewModel;
  final Course courseDetailCourse;

  const _CartView({
    Key key,
    @required this.cartViewModel,
    @required this.courseDetailCourse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courses = cartViewModel.cartCourses;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        courses.isNotEmpty ? Text('${courses.length} Item', style: context.textTheme().headline6) : SizedBox(),
        UIHelper.verticalSpaceMedium(),
        ListView.separated(
          shrinkWrap: true,
          itemCount: courses.length,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => Divider(),
          itemBuilder: (_, index) => CartCourseItem(
            course: courses[index],
            onRemoved: () async {
              final isRemoved = await cartViewModel.removeCartCourse(courses[index], courseDetailCourse);
              if (isRemoved) {
                print('Cart item removed successfully');
              }
            },
          ),
        ),
      ],
    );
  }

  void buyCourse(CartViewModel model, Course course, BuildContext context) async {
    Navigator.pushNamed(context, ViewRoutes.paymentSelection, arguments: course);
  }

  void buyAllCourse(CartViewModel model, List<Course> courses, BuildContext context) async {}
}
