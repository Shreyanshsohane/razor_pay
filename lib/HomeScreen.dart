import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _razorpay = Razorpay();
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Razor_Pay'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: amountController,
              decoration: InputDecoration(hintText: "Enter your ammount"),
            ),
          ),
          CupertinoButton(
            color: Colors.lightBlue,
            child: Text('Pay Amount '),
            onPressed: () {
              var options = {
                'key': "<KEY>",
                'amount': (int.parse(amountController.text) * 100).toString(),
                'name': 'Shreyansh Sohane',
                'description': 'Demo',
                'prefill': {
                  'contact': '8942862999',
                  'email': 'test@razorpay.com'
                }
              };
              _razorpay.open(options);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }
}
