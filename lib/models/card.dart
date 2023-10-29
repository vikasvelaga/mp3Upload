
class Card {
  int id; // Unique identifier for the card
  int deckId; // The ID of the deck this card belongs to
  String question; // Question on the card
  String answer; // Answer on the card
  static const String cardTableName = 'cards';
  static const String cardIdColumn = 'id';
  static const String deckIdColumn = 'deck_id';
  static const String questionColumn = 'question';
  static const String answerColumn = 'answer';

  Card({required this.id, required this.deckId,required this.question,required this.answer});
  
  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json['id'],
      deckId: json['deckId'],
      question: json['question'],
      answer: json['answer'],
    );
  }

  
  factory Card.fromMap(Map<String, dynamic> map) {
    return Card(
      id: map['id'],
      deckId: map['deckId'],
      question: map['question'],
      answer: map['answer'],
    );
  }

  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'deckId': deckId,
      'question': question,
      'answer': answer,
    };
  }
}
