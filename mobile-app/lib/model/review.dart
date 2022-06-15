class Review{
int? reviewId;
int? transportId;
String? textReview;
double? rating;
Review.all({
  required this.reviewId,
  required this.transportId,
  required this.textReview,
  required this.rating
});
Review.custom({
  required this.textReview,
  required this.rating
});
static Review mapJsonToReview(Map jsonData){
  return Review.all(reviewId: jsonData["reviewId"],
   transportId: jsonData["transportId"],
    textReview: jsonData["textReview"],
     rating: jsonData["rating"]);
}
  Map<String, dynamic> toJson() {
    return {
      "textReview":textReview,
     "rating":rating
    };
  }
}