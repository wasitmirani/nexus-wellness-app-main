import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_authorize_net_client/flutter_authorize_net_client.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:nexuswellness/assets/apiUrls.dart';
import 'package:http/http.dart' as http;
import 'package:nexuswellness/assets/constants.dart';
import 'package:nexuswellness/widgets/mainwidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomizePlanPayment extends StatefulWidget {
  const CustomizePlanPayment({Key? key}) : super(key: key);

  @override
  _CustomizePlanPaymentState createState() => _CustomizePlanPaymentState();
}

class _CustomizePlanPaymentState extends State<CustomizePlanPayment> {
  String price = "120.00";
  String currency = "USD";
  TextEditingController cardTextController = new TextEditingController();
  TextEditingController dateTextController = new TextEditingController();
  TextEditingController cvvTextController = new TextEditingController();
  TextEditingController cardHolderTextController = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  late AuthorizeNetClient _client;
  late String _refID;

  @override
  void initState() {
    super.initState();
    _client = AuthorizeNetClient(
      '49HYnF9ap3',
      '34X64r498YN9Hwtr',
      environment: AuthorizeNetClient.ENV_TEST,
    );
  }

  bool loading = false;
  updateUserPlane(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    setState(() {
      loading = true;
    });
    var url = update_plane_user;
    final response = await http.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + token,
      },
      body: {
        'plane_id': id.toString(),
      },
    );
    // print(response.statusCod);
    if (response.statusCode == 201) {
      Navigator.pushNamed(context, '/new/feeds');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kgreenColor),
        title: Center(
            child: Text("Customize Membership",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800))),
        elevation: 0,
      ),
      body: new Stack(children: <Widget>[
        planBgScreen("customizeplanbg.png"),
        Column(
          children: [
            SizedBox(height: 20),
            Text("Total Price",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("\$" + price.toString(),
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.w800)),
            ),

            // Text("Payment Method",
            //     style: TextStyle(
            //         fontSize: 14,
            //         color: Colors.white,
            //         fontWeight: FontWeight.w400)),
            SizedBox(height: 10),
            CreditCardWidget(
              cardBgColor: Colors.black,
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
            ),
            SizedBox(height: 20),
          ],
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.2),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CreditCardForm(
                    formKey: formKey,
                    obscureCvv: true,
                    obscureNumber: true,
                    cardNumber: cardNumber,
                    cvvCode: cvvCode,
                    cardHolderName: cardHolderName,
                    expiryDate: expiryDate,
                    themeColor: Color(kgreenColor),
                    cardNumberDecoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                    ),
                    expiryDateDecoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Expired Date',
                      hintText: 'MM/YY',
                    ),
                    cvvCodeDecoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CVV',
                      hintText: 'XXX',
                    ),
                    cardHolderDecoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Card Holder',
                    ),
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                  Container(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        primary: const Color(kgreenColor),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        child: const Text(
                          'Proceed To Pay ',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'halter',
                            fontSize: 14,
                            package: 'flutter_credit_card',
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          print('valid!');
                          final response = await _client.chargeCreditCard(
                            price,
                            'USD'.toLowerCase(),
                            cardNumber.replaceAll(' ', ''),
                            expiryDate,
                            cvvCode,
                          );
                          if (response.isSuccessful) {
                            final snackBar = SnackBar(
                              content: Text(
                                  'Your transaction was successfully processed'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            updateUserPlane(2);
                          }
                          print(cardNumber.replaceAll(' ', ''));
                          print('response: \n${response.toJson()}');
                          print('isSuccessFul: ${response.isSuccessful}');
                          print(jsonEncode(response.toJson()));
                        } else {
                          print('invalid!');
                          final snackBar = SnackBar(
                            content: Text(
                                'Your transaction has been failed. Please try again'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
