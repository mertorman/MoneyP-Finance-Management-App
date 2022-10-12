class OnBoardModel {
  String title;
  String desc;
  String imageUrl;

  OnBoardModel(this.title, this.desc, this.imageUrl);

  String get getImageUrl => 'assets/images/$imageUrl.svg';
}

class OnBoardModels {
  static final List<OnBoardModel> onBoardModels = [
    OnBoardModel(
        'Track Your Spend',
        'Do you have trouble in tracking and managing your money expenses ? Take note of your money expenses with moneyp app, track them easily',
        'onboard_1'),
    OnBoardModel(
        'Calculate Your Spend',
        'Calculate your money expenses easily, keep your money in your wallet',
        'onboard_2'),
    OnBoardModel(
        'See Your Daily And Monthly Expenses',
        'You can see your daily and monthly expenses and review your money expenses.',
        'onboard_3'),
  ];
}
