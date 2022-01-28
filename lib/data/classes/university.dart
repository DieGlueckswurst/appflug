import 'package:appflug/data/classes/review.dart';
import 'package:appflug/data/classes/university_image.dart';
import 'package:appflug/enums/courses.dart';

class University {
  final String id;
  final String name;
  final String countryCode;
  final String city;
  final String description;
  final double requiredGPA;
  final String websiteUrl;
  final String logoDownloadUrl;
  List<Review> reviews;
  List<UniversityImage> images;
  List<Course> coursesOfStudy;

  University({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.city,
    required this.description,
    required this.requiredGPA,
    required this.websiteUrl,
    required this.logoDownloadUrl,
    required this.images,
    required this.reviews,
    required this.coursesOfStudy,
  });
}
