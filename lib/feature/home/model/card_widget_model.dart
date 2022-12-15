class CardModel {
  String cardTitle;
  

  CardModel(
      {required this.cardTitle,
      });
}

class CardModels {
  static final List<CardModel> cardItems = [
    CardModel(
        cardTitle: 'Income',
        ),
    CardModel(
        cardTitle: 'Spent',
     ),
  ];
}
