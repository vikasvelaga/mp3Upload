import 'package:flutter/material.dart';
import 'package:mp3_solution/models/card.dart' as myCard; 

class CardEditorPage extends StatefulWidget {
  final myCard.Card? card; 

  CardEditorPage({this.card});

  @override
  _CardEditorPageState createState() => _CardEditorPageState();
}

class _CardEditorPageState extends State<CardEditorPage> {
  String? question;
  String? answer;

  @override
  void initState() {
    super.initState();
    if (widget.card != null) {
      question = widget.card!.question;
      answer = widget.card!.answer;
    }
  }

  void saveCard() {
    if (question != null && answer != null) {
      
      Navigator.pop(context);
    }
  }

  void deleteCard() {
    if (widget.card != null) {
      
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Editor'),
        actions: <Widget>[
          if (widget.card != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: deleteCard,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: TextEditingController(text: question),
              onChanged: (value) {
                question = value;
              },
              decoration: InputDecoration(labelText: 'Question'),
            ),
            TextField(
              controller: TextEditingController(text: answer),
              onChanged: (value) {
                answer = value;
              },
              decoration: InputDecoration(labelText: 'Answer'),
            ),
            ElevatedButton(
              onPressed: saveCard,
              child: Text('Save Card'),
            ),
          ],
        ),
      ),
    );
  }
}
