import 'package:appflug/data/classes/review.dart';
import 'package:collection/collection.dart';

class ReviewService {
  static double getReviewAverage(List<Review> reviews) {
    return reviews
            .map(
              (review) => review.average!,
            )
            .toList()
            .sum /
        reviews.length;
  }
}
