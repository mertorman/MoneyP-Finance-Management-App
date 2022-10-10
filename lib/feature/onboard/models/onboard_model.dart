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
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
        'onboard_1'),
    OnBoardModel(
        'Calculate Your Spend',
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
        'onboard_2'),
    OnBoardModel(
        'See Your Daily And Monthly Expenses',
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
        'onboard_3'),
  ];
}
