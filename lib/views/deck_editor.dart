import 'package:flutter/material.dart';
import 'package:mp3_solution/models/deck.dart'; 

class DeckEditorPage extends StatefulWidget {
  final Deck? deck; 

  DeckEditorPage({this.deck});

  @override
  _DeckEditorPageState createState() => _DeckEditorPageState();
}

class _DeckEditorPageState extends State<DeckEditorPage> {
  String? deckTitle;

  @override
  void initState() {
    super.initState();
    if (widget.deck != null) {
      deckTitle = widget.deck!.title;
    }
  }

  void saveDeck() {
    if (deckTitle != null) {
      
      Navigator.pop(context);
    }
  }

  void deleteDeck() {
    if (widget.deck != null) {
      
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deck Editor'),
        actions: <Widget>[
          if (widget.deck != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: deleteDeck,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: TextEditingController(text: deckTitle),
              onChanged: (value) {
                deckTitle = value;
              },
              decoration: InputDecoration(labelText: 'Deck Title'),
            ),
            ElevatedButton(
              onPressed: saveDeck,
              child: Text('Save Deck'),
            ),
          ],
        ),
      ),
    );
  }
}
