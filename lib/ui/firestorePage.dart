import 'package:flutter/material.dart';
import '../helpers/cardDrawer.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../helpers/cardColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ui/cardType.dart';

class FirestorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text('Card Wallet'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              color: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CardType()));
              },
            ),
          ],
        ),
        drawer: cardDrawer(context),
        body: StreamBuilder(
          stream: Firestore.instance.collection('Cards').snapshots(),
          builder: (context, snapshot) {
            return Column(
              children: <Widget>[
                !snapshot.hasData
                    ? CircularProgressIndicator()
                    : SizedBox(
                        height: _screensize.height * 0.8,
                        child: Swiper(
                          onTap: (int index) {
                            print(snapshot.data.documents[index]['name']);
                          },
                          itemCount: snapshot.data.documents.length,
                          itemHeight: _screensize.height * 0.5,
                          itemWidth: _screensize.width * 0.7,
                          layout: SwiperLayout.STACK,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return cardFrontList(
                                snapshot.data.documents[index], index);
                          },
                        ),
                      ),
              ],
            );
          },
        ));
  }
}

Widget cardFrontList(DocumentSnapshot cardModel, int index) {
  Widget _buildNumbers() {
    return Text(cardModel['number'].substring(12),
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ));
  }

  Widget _buildDots() {
    List<Widget> dotList = new List<Widget>();
    var counter = 0;
    for (var i = 0; i < 12; i++) {
      counter += 1;
      dotList.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.0),
        child: Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ));
      if (counter == 4) {
        counter = 0;
        dotList.add(SizedBox(
          width: 10.0,
        ));
      }
    }
    dotList.add(_buildNumbers());
    return Row(
      children: dotList,
    );
  }

  final _cardLogo = Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
      Padding(
          padding: EdgeInsets.only(top: 20.0, right: 30.0),
          child: Image(
            image: (cardModel['company'] == 'VISA')
                ? AssetImage('assets/visa.png')
                : AssetImage('assets/mastercard.png'),
            width: 50.0,
            height: 25.0,
          )),
      Padding(
        padding: EdgeInsets.only(right: 30.0),
        child: Text(
          cardModel['type'].toString().toUpperCase(),
          style: TextStyle(
              color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w400),
        ),
      )
    ],
  );
  final _cardChip = Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 30.0),
        child: Image.asset('assets/chip.png', width: 65, height: 60),
      )
    ],
  );
  final _cardNumber = Padding(
    padding: EdgeInsets.only(top: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildDots(),
      ],
    ),
  );
  final _cardLastNumber = Padding(
    padding: EdgeInsets.only(top: 1.0, left: 55.0),
    child: Text(
      cardModel['number'].substring(12),
      style: TextStyle(
        color: Colors.white,
        fontSize: 8.0,
      ),
    ),
  );
  final _cardValidthru = Padding(
    padding: EdgeInsets.only(top: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              'valid',
              style: TextStyle(fontSize: 8.0, color: Colors.white),
            ),
            Text(
              'thru',
              style: TextStyle(fontSize: 8.0, color: Colors.white),
            )
          ],
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          cardModel['month'] + '/' + cardModel['year'].substring(2),
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        )
      ],
    ),
  );
  final _cardOwner = Padding(
      padding: EdgeInsets.only(top: 15.0, left: 50.0, right: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(cardModel['name'].toString().toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
          Image(
            image: (cardModel['bank'] == 'BCP')
                ? AssetImage('assets/bcp.png')
                : AssetImage('assets/bbva.png'),
            width: 50.0,
          )
        ],
      ));

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      color: CardColor.baseColors[index],
    ),
    child: RotatedBox(
      quarterTurns: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _cardLogo,
          _cardChip,
          _cardNumber,
          _cardLastNumber,
          _cardValidthru,
          _cardOwner
        ],
      ),
    ),
  );
}
