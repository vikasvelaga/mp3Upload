import 'package:flutter/src/material/card.dart';

class Deck {
  int id; 
  String title;
  static const String deckTableName = 'decks';
  static const String deckIdColumn = 'id';
  static const String deckTitleColumn = 'title';

  Deck({required this.id,required this.title});

  factory Deck.fromJson(Map<String, dynamic> json) {
    return Deck(
      id: json['id'],
      title: json['title'],
    );
  }

  
  factory Deck.fromMap(Map<String, dynamic> map) {
    return Deck(
      id: map['id'],
      title: map['title'],
    );
  }

  set cards(List<Card> cards) {}

  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }
}
