import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../core/constants/app_barrel.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/models/course/course.dart';
import '../../../core/repositories/course/course_repository.dart';
import '../../../core/services/payment/payment_service.dart';
import '../../../core/view_models/payment_existing_card_view_model.dart';
import '../../shared/app_style.dart';
import '../../shared/ui_helper.dart';
import '../base_view.dart';

class PaymentExistingCardPage extends StatefulWidget {
  final Course course;

  const PaymentExistingCardPage({Key key, this.course}) : super(key: key);

  @override
  _PaymentExistingCardPageState createState() => _PaymentExistingCardPageState();
}

class _PaymentExistingCardPageState extends State<PaymentExistingCardPage> {
  bool isLoading = false;
  List cards = [
    {
      'cardNumber': '5104015555555558',
      'expiryDate': '08/22',
      'cardHolderName': 'Vinoth',
      'cvvCode': '423',
      'showBackView': false,
    },
    {
      'cardNumber': '4111111111111111',
      'expiryDate': '10/24',
      'cardHolderName': 'Abservetech',
      'cvvCode': '253',
      'showBackView': false,
    }
  ];

  TextEditingController creditCardController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expirationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return BaseView<PaymentExistingCardViewModel>(
      model: PaymentExistingCardViewModel(
        paymentService: PaymentService(razorpay: Razorpay()),
        courseRepository: CourseRepository(),
      ),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(locale.chooseExistingCardsNavTitle, style: appBarTheme),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) {
              var card = cards[index];
              return InkWell(
                onTap: () => payViaExistingCard(context, model, card),
                child: CreditCardWidget(
                  cardNumber: card['cardNumber'],
                  expiryDate: card['expiryDate'],
                  cardHolderName: card['cardHolderName'],
                  cvvCode: card['cvvCode'],
                  showBackView: false,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void payViaExistingCard(BuildContext context, PaymentExistingCardViewModel model, Map<String, dynamic> card) async {
    var expiryArray = card['expiryDate'].split('/');
    // CreditCard creditCard = CreditCard(
    //   number: card['cardNumber'],
    //   expMonth: int.parse(expiryArray[0]),
    //   expYear: int.parse(expiryArray[1]),
    // );
    final Map<String, dynamic> checkOutOptions = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': widget.course.price,
      'amount_paid': 1,
      'name': 'Vinoth Vino',
      'description': 'Flutter Advanced Course',
      'currency': 'INR',
      'status': 'created',
      'prefill': {
        'contact': '8888888888',
        'email': 'vinoth@icloud.com',
      },
    };
  }

  void showSnackBar(BuildContext context, String text, {bool isLoading = true}) {
    Scaffold.of(context).showSnackBar(SnackBar(
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
    ));
  }
}
