import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:mp3_solution/models/deck.dart';
import 'package:mp3_solution/models/card.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper._internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'flashcards.db');

    var database = openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );

    return database;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${Deck.deckTableName} (
        ${Deck.deckIdColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Deck.deckTitleColumn} TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE ${Card.cardTableName} (
        ${Card.cardIdColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Card.deckIdColumn} INTEGER,
        ${Card.questionColumn} TEXT,
        ${Card.answerColumn} TEXT,
        FOREIGN KEY (${Card.deckIdColumn}) REFERENCES ${Deck.deckTableName} (${Deck.deckIdColumn})
      )
    ''');
  }

  Future<int> insertDeck(Deck deck) async {
    Database dbClient = await db;
    return await dbClient.insert(Deck.deckTableName, deck.toMap());
  }

  Future<int> updateDeck(Deck deck) async {
    Database dbClient = await db;
    return await dbClient.update(
      Deck.deckTableName,
      deck.toMap(),
      where: '${Deck.deckIdColumn} = ?',
      whereArgs: [deck.id],
    );
  }

  Future<int> deleteDeck(int deckId) async {
    Database dbClient = await db;
    return await dbClient.delete(
      Deck.deckTableName,
      where: '${Deck.deckIdColumn} = ?',
      whereArgs: [deckId],
    );
  }

  Future<List<Deck>> getDecks() async {
    Database dbClient = await db;
    List<Map<String, dynamic>> decks = await dbClient.query(Deck.deckTableName);

    return decks.isNotEmpty
        ? decks.map((deck) => Deck.fromMap(deck)).toList()
        : [];
  }

  // Implement similar methods for cards (insert, update, delete, get)
  Future<int> insertCard(Card card) async {
    Database dbClient = await db;
    return await dbClient.insert(Card.cardTableName, card.toMap());
  }

  Future<int> updateCard(Card card) async {
    Database dbClient = await db;
    return await dbClient.update(
      Card.cardTableName,
      card.toMap(),
      where: '${Card.cardIdColumn} = ?',
      whereArgs: [card.id],
    );
  }

  Future<int> deleteCard(int cardId) async {
    Database dbClient = await db;
    return await dbClient.delete(
      Card.cardTableName,
      where: '${Card.cardIdColumn} = ?',
      whereArgs: [cardId],
    );
  }

  Future<List<Card>> getCards(int deckId) async {
    Database dbClient = await db;
    List<Map<String, dynamic>> cards = await dbClient.query(
      Card.cardTableName,
      where: '${Card.deckIdColumn} = ?',
      whereArgs: [deckId],
    );

    return cards.isNotEmpty
        ? cards.map((card) => Card.fromMap(card)).toList()
        : [];
  }
  Future<void> loadStarterData() async {
  final jsonString = await rootBundle.loadString('assets/flashcards.json');
  final jsonData = json.decode(jsonString);

  for (var deckData in jsonData['decks']) {
    final deck = Deck.fromJson(deckData);
    await insertDeck(deck);

    for (var cardData in deckData['cards']) {
      final card = Card.fromJson(cardData);
      card.deckId = deck.id;
      await insertCard(card);
    }
  }
}

}
