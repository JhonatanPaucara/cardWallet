import 'package:card_wallet/ui/newCardData.dart';
import 'package:flutter/material.dart';
import 'newCardData.dart';

class CardType extends StatelessWidget {
  final cardTypeDescription = Padding(
    padding: EdgeInsets.all(5.0),
    child: Text.rich(
      TextSpan(
        text:
            'Select your card type. If you don\'t know what kind of card you have, click ',
        children: <TextSpan>[
          TextSpan(
            text: 'here',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Select Card Type',
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
            _buildRaisedButton(
                btnColor: Colors.blue,
                btnName: 'Credit Card',
                txtColor: Colors.white,
                context: context),
            _buildRaisedButton(
                btnColor: Colors.white,
                btnName: 'Debit Card',
                txtColor: Colors.black,
                context: context),
            _buildRaisedButton(
                btnColor: Colors.white,
                btnName: 'Gif Card',
                txtColor: Colors.black,
                context: context),
            cardTypeDescription
          ],
        ),
      ),
    );
  }

  Widget _buildRaisedButton(
      {Color btnColor, String btnName, Color txtColor, BuildContext context}) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: RaisedButton(
        color: btnColor,
        elevation: 1.0,
        onPressed: () {
          String _cardType = btnName.split(" ")[0];
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewCardData(cardType: _cardType)));
        },
        child: Text(btnName,
            style: TextStyle(
              color: txtColor,
            )),
      ),
    );
  }
}
