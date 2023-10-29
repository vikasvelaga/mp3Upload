import 'package:flutter/material.dart';
import 'package:mp3_solution/models/card.dart'
    as myCard; 
import 'card_editor.dart';
import 'quiz.dart';

class CardListPage extends StatefulWidget {
  final List<myCard.Card> cards; 

  CardListPage({required this.cards});

  @override
  _CardListPageState createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  
  bool _sortAscending = true;
  int _sortColumnIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Cards'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.quiz),
            onPressed: () {
              // Navigate to the Quiz page with the cards
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => QuizPage(flashcards: widget.cards),
              ));
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshKey,
        onRefresh: () async {
          
        },
        child: ListView(
          children: <Widget>[
            
            DataTable(
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              columns: [
                DataColumn(
                  label: Text('Question'),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      _sortColumnIndex = columnIndex;
                      _sortAscending = ascending;
                      
                      widget.cards.sort((a, b) {
                        if (ascending) {
                          return a.question.compareTo(b.question);
                        } else {
                          return b.question.compareTo(a.question);
                        }
                      });
                    });
                  },
                ),
                DataColumn(
                  label: Text('Actions'),
                ),
              ],
              rows: widget.cards
                  .map(
                    (card) => DataRow(
                      cells: [
                        DataCell(
                          Text(card.question),
                        ),
                        DataCell(
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  // Edit the card
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CardEditorPage(
                                        card: card,
                                        
                                      ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

