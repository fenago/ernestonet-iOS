import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/constants/view_routes.dart';
import '../../../core/models/course/course.dart';
import '../../../core/repositories/course/course_repository.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../core/services/payment/payment_service.dart';
import '../../../core/utils/alert_dialog_helper.dart' as alert_helper;
import '../../../core/view_models/base_view_model.dart';
import '../../../core/view_models/cart_badge_view_model.dart';
import '../../../core/view_models/payment_selection_view_model.dart';
import '../../../locator.dart';
import '../../shared/app_style.dart';
import '../../shared/ui_helper.dart';
import '../base_view.dart';

class PaymentSelectionPage extends StatefulWidget {
  final List<Course> courses;

  const PaymentSelectionPage({Key key, this.courses}) : super(key: key);

  @override
  _PaymentSelectionPageState createState() => _PaymentSelectionPageState();
}

class _PaymentSelectionPageState extends State<PaymentSelectionPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _kRazorpayKey = '';
  Map<String, String> stripeKeyCredentials;

  @override
  Widget build(BuildContext context) {
    return BaseView<PaymentSelectionViewModel>(
        model: PaymentSelectionViewModel(
          paymentService: PaymentService(razorpay: Razorpay()),
          courseRepository: CourseRepository(),
        ),
        onModelReady: (model) => model.getPaymentList(),
        builder: (context, model, widget) {
          for (var payment in model.paymentGateways) {
            if (payment.title == 'Razorpay') {
              _kRazorpayKey = payment.apiKey;
            } else if (payment.title == 'Stripe') {
              stripeKeyCredentials = {
                'api_key': payment.apiKey,
                'secret_key': payment.secretKey,
              };
            }
          }

          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(title: Text('Payment', style: appBarTheme)),
            body: Container(
              padding: const EdgeInsets.all(15.0),
              child: model.fetchPaymentLoading
                  ? Center(child: CircularProgressIndicator())
                  : model.paymentGateways.isEmpty
                      ? Center(
                          child: Text(
                            'Payment Gateways not found',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: model.paymentGateways.length,
                                separatorBuilder: (context, index) => Divider(),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () => onItemPressed(context, model, index),
                                    child: ListTile(
                                      leading: Icon(Icons.add_circle, color: Palette.appColor),
                                      title: Text(model.paymentGateways[index].title),
                                      dense: true,
                                    ),
                                  );
                                },
                              ),
                            ),
                            if (model.state == ViewState.busy) Center(child: CircularProgressIndicator())
                          ],
                        ),
            ),
          );
        });
  }

  void onItemPressed(BuildContext context, PaymentSelectionViewModel model, int index) async {
    print('index: ${index.toString()};');
    switch (model.paymentGateways[index].title) {
      case 'Razorpay':
        if (model.paymentGateways[index].apiKey.isNotEmpty && model.paymentGateways[index].apiKey != null) {
          initiateRazorpay(model);
        } else {
          alert_helper.showErrorAlert('There is no api key provided for Razorpay');
        }
        break;
      case 'Stripe':
        if (model.paymentGateways[index].apiKey.isNotEmpty && model.paymentGateways[index].apiKey != null) {
          initiateStripePayment(model);
        } else {
          alert_helper.showErrorAlert('There is no api key provided for Stripe');
        }
        break;
    }
  }

  void initiateRazorpay(PaymentSelectionViewModel model) async {
    final user = locator<LocalStorageService>().user;
    int amount = 0;
    String courseName = '';

    widget.courses.forEach((course) {
      courseName = courseName + ', ' + course.title;
      amount = amount + int.parse(course.price);
    });

    amount = amount * 100;

    final Map<String, dynamic> checkoutOptions = {
      'key': _kRazorpayKey,
      'amount': amount,
      'name': user.name,
      'description': '${Constant.appTitle} Learning',
      'currency': 'INR',
      'status': 'created',
      'prefill': {
        'contact': user.mobile,
        'email': user.email,
      },
    };

    await model.payWithRazorpay(widget.courses, checkoutOptions, (status) {
      print('PayWithRazorpay finished executing');
      if (status) {
        // model.
        context.read<CartBadgeViewModel>().getCartCourses();
        showSnackBar(context, status ? 'Payment Success' : 'Failed to buy course', isLoading: false, success: true);
      }
    });
  }

  void showSnackBar(BuildContext context, String text, {bool isLoading = true, bool success = false}) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            Flexible(child: Text(text, maxLines: 2)),
            UIHelper.horizontalSpaceLarge(),
            isLoading
                ? SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Palette.appColor),
                      strokeWidth: 2.0,
                    ),
                  )
                : SizedBox()
          ],
        ),
        duration: Duration(seconds: 2),
      ),
    );
    if (success) {
      Navigator.pushNamed(context, ViewRoutes.courseEnrolledStarted, arguments: widget.courses[0]);
    }
  }

  /// STRIPE
  void initiateStripePayment(PaymentSelectionViewModel model) async {
    showSnackBar(context, 'Processing..');
    var response = await model.payWithCard(stripeKeyCredentials, widget.courses);
    if (response.success) {
      showSnackBar(context, response.message, isLoading: false);
      Future.delayed(
        Duration(milliseconds: 500),
        () async {
          if (response.success) {
            final success = await model.buyPaidCourse(widget.courses, '1234');
            if (success) {
              context.read<CartBadgeViewModel>().getCartCourses();
              showSnackBar(context, model.paymentSuccess ? 'Payment Success' : 'Failed to buy course', isLoading: false, success: response.success);
            }
          }
        },
      );
    } else {
      alert_helper.showErrorAlert(response.message);
    }
  }
}
