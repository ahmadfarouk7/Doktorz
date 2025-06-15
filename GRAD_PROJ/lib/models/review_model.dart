class ReviewModel {
  dynamic review;
  dynamic rating;
  dynamic fullName;
  dynamic image;
  dynamic createdAt;

  ReviewModel({
    required this.review,
    required this.rating,
    required this.fullName,
    required this.image,
    required this.createdAt
  });

  factory ReviewModel.fromJson(json) {
    return ReviewModel(
      review: json['review'],
      rating: json['rating'],
      fullName: json['user']['fullName'],
      image: json['user']['photo'],
      createdAt:json['createdAt'],
    );
  }
}
