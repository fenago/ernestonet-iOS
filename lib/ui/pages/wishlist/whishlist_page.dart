import 'package:edustar/core/view_models/base_view_model.dart';
import 'package:edustar/core/view_models/cart_badge_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/asset_images.dart';
import '../../../core/constants/view_routes.dart';
import '../../../core/extensions/theme_x.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/repositories/course/course_repository.dart';
import '../../../core/view_models/wishlist_view_model.dart';
import '../base_view.dart';
import '../course/course_list_shimmer_page.dart';
import '../../widgets/cart_badge_icon.dart';
import '../../widgets/course/course_list_item.dart';
import '../../widgets/course/course_wishlist_empty.dart';
import '../../widgets/remove_list_item.dart';

class WishListPage extends StatefulWidget {
  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return BaseView<WishlistViewModel>(
      model: WishlistViewModel(
        courseRepository: CourseRepository(),
      ),
      onModelReady: (model) => model.getAllWishlistCourses(1),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          title: Text(
            locale.wishlistNavTitle,
            style: context.textTheme().headline6.copyWith(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            CartBadgeIcon(
              onPressed: () async {
                final isPopped = await Navigator.pushNamed(context, ViewRoutes.cart);
                if (isPopped) {
                  await context.read<CartBadgeViewModel>().getCartCourses();
                  await model.getAllWishlistCourses(1);
                  print('isPopped : $isPopped');
                }
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            child: (model.myWishlistCourse == null)
                ? CourseListShimmerPage()
                : (model.myWishlistCourse.isEmpty)
                    ? CourseWishlistEmpty(
                        emptyImage: AssetImages.emptyWishlist,
                        title: locale.emptyWishlist,
                        buttonTitle: locale.browseCourse,
                      )
                    : Container(
                        alignment: Alignment.center,
                        color: context.theme().scaffoldBackgroundColor,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: WishlistCourseList(model: model),
                            ),
                          ],
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}

class WishlistCourseList extends StatefulWidget {
  final WishlistViewModel model;

  const WishlistCourseList({
    Key key,
    @required this.model,
  }) : super(key: key);

  @override
  _WishlistCourseListState createState() => _WishlistCourseListState();
}

class _WishlistCourseListState extends State<WishlistCourseList> {
  int currentSwipeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          print('Reached end');
          widget.model.updatePageNo(widget.model.page + 1);
          widget.model.getAllWishlistCourses(widget.model.page);
        } else {
          print('Scrolling...');
        }
        return false;
      },
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: widget.model.myWishlistCourse.length,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => Dismissible(
          background: RemoveListItem(),
          key: Key('{${widget.model}.myWishlistCourse[index].id}'),
          onDismissed: (direction) async {
            currentSwipeIndex = index;
            final isRemoved = await widget.model.removeFromWishlist(widget.model.myWishlistCourse[index].id);
            if (isRemoved) {}
            setState(() {
              widget.model.myWishlistCourse.removeAt(index);
            });
          },
          child: InkWell(
            onTap: () async {
              if (widget.model.myWishlistCourse[index].enrolled) {
                Navigator.pushNamed(context, ViewRoutes.purchaseCourseDetail, arguments: widget.model.myWishlistCourse[index]);
              } else {
                final isPopped = await Navigator.pushNamed(context, ViewRoutes.courseDetail, arguments: widget.model.myWishlistCourse[index]);

                if (isPopped) {
                  await context.read<CartBadgeViewModel>().getCartCourses();
                  await widget.model.getAllWishlistCourses(widget.model.page);
                  print('isPopped : $isPopped');
                }
              }
            },
            child: CourseListItem(
              course: widget.model.myWishlistCourse[index],
            ),
          ),
        ),
      ),
    );
  }
}
