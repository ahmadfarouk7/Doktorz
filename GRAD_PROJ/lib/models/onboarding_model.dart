class OnboardingModel {
  String img;
  String title;
  String subTitle;
  bool cover;

  OnboardingModel({
    required this.img,
    required this.title,
    required this.subTitle,
    this.cover = true,
  });
}
