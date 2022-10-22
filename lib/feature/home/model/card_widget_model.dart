class CardModel {
  String cardTitle;
  String cardMoneyIcon;
  String cardTotalMoney;
  String cardSpendMoney;

  CardModel(
      {required this.cardTitle,
      required this.cardMoneyIcon,
      required this.cardTotalMoney,
      required this.cardSpendMoney});
}

class CardModels {
  static final List<CardModel> cardItems = [
    CardModel(
        cardTitle: 'Total',
        cardMoneyIcon: "₺",
        cardTotalMoney: '2,500',
        cardSpendMoney: '3000'),
    CardModel(
        cardTitle: 'Spent',
        cardMoneyIcon: "₺",
        cardTotalMoney: '2,500',
        cardSpendMoney: '3000'),
  ];
}
