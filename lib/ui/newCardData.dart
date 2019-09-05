import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/cardModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewCardData extends StatefulWidget {
  final String cardType;
  NewCardData({this.cardType});
  @override
  _NewCardDataState createState() => _NewCardDataState(newCardType: cardType);
}

class _NewCardDataState extends State<NewCardData> {
  String newCardType;
  final _formKey = GlobalKey<FormState>();
  _NewCardDataState({this.newCardType});
  CardResults _newCard = new CardResults();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'New $newCardType Card',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.clear),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /*Text(_newCard == null || _newCard.cardName == null
                ? 'Name Lastname'
                : _newCard.cardName),
            TextField(
              onChanged: (text) {
                setState(() {
                  _newCard.cardName = text.toUpperCase();
                });
              },
            ),*/
            Text('Enter your card information'),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(16),
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                        labelText: 'Card Number',
                        hintText: '**** **** **** ****',
                        prefixIcon: Icon(Icons.credit_card)),
                    validator: (cardNumber) {
                      if (cardNumber.length != 16) {
                        return 'Card number should have 16 digits';
                      }
                      _newCard.cardNumber = cardNumber;
                      return null;
                    },
                  ),
                  TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(RegExp("[^0-9]")),
                    ],
                    decoration: InputDecoration(
                        labelText: 'Card Name',
                        hintText: 'NAME LASTNAME',
                        prefixIcon: Icon(Icons.person)),
                    validator: (cardName) {
                      if (cardName == '') {
                        return 'Enter your name as it appears in your card';
                      }
                      _newCard.cardName = cardName.toUpperCase();
                      return null;
                    },
                  ),
                  TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(RegExp("[^0-9]")),
                    ],
                    decoration: InputDecoration(
                        labelText: 'Company',
                        hintText: 'VISA  o MASTERCARD',
                        prefixIcon: Icon(Icons.card_giftcard)),
                    validator: (cardCompany) {
                      if (cardCompany == '') {
                        return 'Enter your card company';
                      }
                      _newCard.cardCompany = cardCompany.toUpperCase();
                      return null;
                    },
                  ),
                  TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(RegExp("[^0-9]")),
                    ],
                    decoration: InputDecoration(
                        labelText: 'Bank',
                        hintText: 'BCP, BBVA, ETC',
                        prefixIcon: Icon(Icons.account_balance)),
                    validator: (cardBank) {
                      if (cardBank == '') {
                        return 'Enter your card bank';
                      }
                      _newCard.cardBank = cardBank.toUpperCase();
                      return null;
                    },
                  ),
                  TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(RegExp("[^a-zA-Z]")),
                    ],
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        labelText: 'Exp. Date',
                        hintText: '07/19',
                        prefixIcon: Icon(Icons.calendar_today)),
                    validator: (cardDate) {
                      if (cardDate == '') {
                        return 'Enter your card expiration date';
                      }
                      _newCard.cardMonth = cardDate.substring(0, 2);
                      _newCard.cardYear = '20' + cardDate.substring(3, 5);
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      color: _formKey.currentState == null
                          ? Colors.grey
                          : (_formKey.currentState.validate()
                              ? Colors.lightBlue
                              : Colors.grey),
                      onPressed: () {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.
                          print('Processing Data ${_newCard.toString()}');
                          Firestore.instance
                              .runTransaction((Transaction tx) async {
                            await Firestore.instance
                                .collection('Cards')
                                .document()
                                .setData({
                              'bank': _newCard.cardBank,
                              'company': _newCard.cardCompany,
                              'year': _newCard.cardYear,
                              'month': _newCard.cardMonth,
                              'cvv': '123',
                              'number': _newCard.cardNumber,
                              'type': newCardType.toUpperCase(),
                              'name': _newCard.cardName,
                            });
                          });
                          Navigator.pop(context);
                        } else {
                          print('Wrong Data ${_newCard.cardYear}');
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
