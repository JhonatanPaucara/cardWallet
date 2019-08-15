import 'package:flutter/material.dart';

class CardModel {
  List<CardResults> results;
  CardModel({this.results});
  CardModel.fromJson(Map<String, dynamic> json) {
    if (json['cardResults'] != null) {
      results = new List<CardResults>();
      json['cardResults'].forEach((v) {
        results.add(new CardResults.fromJson(v));
      });
    }
  }
}

class CardResults {
  String cardName;
  String cardBank;
  String cardNumber;
  String cardMonth;
  String cardYear;
  String cardCvv;
  String cardType;
  String cardCompany;
  Color cardColor;

  CardResults({
    this.cardColor,
    this.cardCompany,
    this.cardCvv,
    this.cardMonth,
    this.cardName,
    this.cardNumber,
    this.cardType,
    this.cardYear,
    this.cardBank,
  });

  CardResults.fromJson(Map<String, dynamic> json) {
    cardName = json['cardName'];
    cardColor = json['cardColor'];
    cardCompany = json['cardCompany'];
    cardCvv = json['cardCvv'];
    cardMonth = json['cardMonth'];
    cardYear = json['cardYear'];
    cardNumber = json['cardNumber'];
    cardType = json['cardType'];
    cardBank = json['cardBank'];
  }
}
