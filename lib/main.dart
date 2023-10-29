import 'package:flutter/material.dart';
import 'package:mp3_solution/views/deck_list.dart';

void main() {
  runApp(MyFlashcardsApp());
}

class MyFlashcardsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcards App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/deckList',
      routes: {
        '/deckList': (context) => DeckListPage(),
        
      },
    );
  }
}
