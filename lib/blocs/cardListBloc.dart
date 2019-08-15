import "dart:async";
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/cardModel.dart';
import 'dart:convert';
import '../helpers/cardColors.dart';

class CardListBloc {
  BehaviorSubject<List<CardResults>> _cardsCollection =
      BehaviorSubject<List<CardResults>>();
  List<CardResults> _cardResults;
  Stream<List<CardResults>> get cardList => _cardsCollection.stream;
  void initialData() async {
    //Get data from Json file
    var initialData = await rootBundle.loadString('data/initialData.json');
    var decodedJson = jsonDecode(initialData);
    _cardResults = CardModel.fromJson(decodedJson).results;
    if (_cardResults != null) {
      for (var i = 0; i < _cardResults.length; i++) {
        _cardResults[i].cardColor = CardColor.baseColors[i];
      }
    }
    _cardsCollection.sink.add(_cardResults);
  }

  CardListBloc() {
    initialData();
  }
  void dispose() {
    _cardsCollection.close();
  }
}

final cardListBloc = CardListBloc();
