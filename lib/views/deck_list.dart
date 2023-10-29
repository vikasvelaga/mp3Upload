import 'package:flutter/material.dart';
import 'package:mp3_solution/models/deck.dart';
import 'deck_editor.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mp3_solution/models/card.dart' as theCard;

class DeckListPage extends StatefulWidget {
  @override
  _DeckListPageState createState() => _DeckListPageState();
}

class _DeckListPageState extends State<DeckListPage> {
  List<Deck> decks = []; 

  @override
  void initState() {
    super.initState();
    loadDecksFromJson(); 
  }

  void loadDecksFromJson() async {
  final String jsonContent = await rootBundle.loadString('assets/flashcards.json');
  final List<dynamic> jsonData = json.decode(jsonContent);

  for (var deckJson in jsonData) {
    final Deck deck = Deck.fromMap({
      'id': 0,  
      'title': deckJson['title'],
    });

    
    final List<theCard.Card> cards = [];
    for (var cardJson in deckJson['flashcards']) {
      cards.add(theCard.Card as theCard.Card);
    }

    
    deck.cards = theCard.Card as List<Card>;
    decks.add(deck);
  }

  setState(() {});
}


  void createDeck() {
    
  }

  void editDeck(Deck deck) {
    
  }

  void deleteDeck(int deckId) {
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deck List'),
      ),
      body: ListView.builder(
        itemCount: decks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(decks[index].title),
            
            
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createDeck,
        child: Icon(Icons.add),
      ),
    );
  }
}
