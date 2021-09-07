import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:truck/network_utils/api.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  static final String tokenizationKey = 'sandbox_cs2jkvwm_mv3frknkgrs3rsxb';

  void showNonce(BraintreePaymentMethodNonce nonce) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Payment method nonce:'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Nonce: ${nonce.nonce}'),
            SizedBox(height: 16),
            Text('Type label: ${nonce.typeLabel}'),
            SizedBox(height: 16),
            Text('Description: ${nonce.description}'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Braintree example app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                var request = BraintreeDropInRequest(
                  tokenizationKey: tokenizationKey,
                  collectDeviceData: true,
                  googlePaymentRequest: BraintreeGooglePaymentRequest(
                    totalPrice: '10.00',
                    currencyCode: 'USD',
                    billingAddressRequired: false,
                  ),
                  paypalRequest: BraintreePayPalRequest(
                    amount: '10.00',
                    displayName: 'Example company',
                  ),
                  cardEnabled: true,
                );
                final result = await BraintreeDropIn.start(request);
                if (result != null) {
                  //print("dsfsd");
                  final resultdata = {
                    'nonce': result.paymentMethodNonce.nonce,
                    'device_data': result.deviceData
                  };

                  var res = await Network().authData(resultdata, '/make');
                  var body = json.decode(res.body);
                  if(body['data']['success']==true){
                    print("body$body");
                    showNonce(result.paymentMethodNonce);
                  }
                  //print("body$body");

                  
                }
              },
              child: Text('Pay'),
            ),
            ElevatedButton(
              onPressed: () async {
                final request = BraintreeCreditCardRequest(
                  cardNumber: '4111111111111111',
                  expirationMonth: '12',
                  expirationYear: '2021',
                  cvv: '123',
                );
                final result = await Braintree.tokenizeCreditCard(
                  tokenizationKey,
                  request,
                );
                if (result != null) {
                  print(result);
                  showNonce(result);
                }
              },
              child: Text('TOKENIZE CREDIT CARD'),
            ),
            ElevatedButton(
              onPressed: () async {
                final request = BraintreePayPalRequest(
                  billingAgreementDescription:
                      'I hereby agree that flutter_braintree is great.',
                  displayName: 'Your Company',
                );
                final result = await Braintree.requestPaypalNonce(
                  tokenizationKey,
                  request,
                );
                if (result != null) {
                  showNonce(result);
                }
              },
              child: Text('PAYPAL VAULT FLOW'),
            ),
            ElevatedButton(
              onPressed: () async {
                final request = BraintreePayPalRequest(amount: '13.37');
                final result = await Braintree.requestPaypalNonce(
                  tokenizationKey,
                  request,
                );
                if (result != null) {
                  showNonce(result);
                }
              },
              child: Text('PAYPAL CHECKOUT FLOW'),
            ),
          ],
        ),
      ),
    );
  }
}
