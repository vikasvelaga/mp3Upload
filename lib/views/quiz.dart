import 'package:flutter/material.dart';
import 'package:mp3_solution/models/card.dart' as CustomCard;

class QuizPage extends StatefulWidget {
  final List<CustomCard.Card> flashcards; 

  QuizPage({required this.flashcards});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentIndex = 0;
  bool showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              'Card ${currentIndex + 1}/${widget.flashcards.length}',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Card(
            margin: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    showAnswer
                        ? widget.flashcards[currentIndex].answer
                        : widget.flashcards[currentIndex].question,
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showAnswer = !showAnswer;
                  });
                },
                child: Text(showAnswer ? 'Question' : 'Answer'),
              ),
              SizedBox(width: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (currentIndex < widget.flashcards.length - 1) {
                    setState(() {
                      currentIndex++;
                      showAnswer = false;
                    });
                  }
                },
                child: Text('Next Card'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
