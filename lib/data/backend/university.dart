import 'package:appflug/data/backend/base.dart';
import 'package:appflug/data/classes/review.dart';
import 'package:appflug/data/classes/university.dart';
import 'package:appflug/data/classes/university_image.dart';
import 'package:appflug/enums/courses.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UniversityBackendService extends BackendService {
  Future<List<University>> getUniversities() async {
    try {
      List<University> universities = [];
      var universityQuerySnapshot =
          await firestoreInstance.collection(keys.universities).get();

      for (var doc in universityQuerySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        List<String> courseOfStudiesString =
            List.from(data[keys.coursesOfStudy] as Iterable<dynamic>);
        List<Course> courseOfStudies = courseOfStudiesString
            .map(
              (courseString) => Course.values.byName(
                courseString,
              ),
            )
            .toList();
        universities.add(
          University(
            id: data[keys.id],
            name: data[keys.name],
            countryCode: data[keys.countryCode],
            city: data[keys.city],
            description: data[keys.description],
            requiredGPA: data[keys.requiredGPA],
            websiteUrl: data[keys.websiteUrl],
            logoDownloadUrl: data[keys.logoDownloadUrl],
            images: [],
            reviews: [],
            coursesOfStudy: courseOfStudies,
          ),
        );
      }
      for (University university in universities) {
        university.images = await getImagesForUniversity(
          university,
        );
      }

      for (University university in universities) {
        university.reviews = await getReviewsForUniversity(
          university,
        );
      }
      return universities;
    } on FirebaseException catch (e) {
      AlertService.showSnackBar(
        title: 'Universitäten laden fehlgeschlagen',
        description: e.message ?? '',
        isSuccess: false,
      );
      return [];
    }
  }

  Future<List<UniversityImage>> getImagesForUniversity(
    University university,
  ) async {
    try {
      List<UniversityImage> images = [];
      QuerySnapshot<Map<String, dynamic>> imagesQuerySnapshot =
          await firestoreInstance
              .collection(keys.universities)
              .doc(university.id)
              .collection(keys.images)
              .get();

      for (var image in imagesQuerySnapshot.docs) {
        Map<String, dynamic> imageData = image.data();
        String id = imageData[keys.id];
        int index = imageData[keys.index];
        String universityId = imageData[keys.universityId];
        String downloadUrl = imageData[keys.downloadUrl];

        images.add(
          UniversityImage(
            id: id,
            index: index,
            universityId: universityId,
            downloadUrl: downloadUrl,
          ),
        );
      }
      images.sort(
        (a, b) => a.index.compareTo(b.index),
      );
      return images;
    } on FirebaseException catch (e) {
      AlertService.showSnackBar(
        title: 'Universitäten laden fehlgeschlagen',
        description: e.message ?? '',
        isSuccess: false,
      );
      return [];
    }
  }

  Future<List<Review>> getReviewsForUniversity(
    University university,
  ) async {
    List<Review> reviews = [];

    var reviewsQuerySnapshot = await firestoreInstance
        .collection(keys.universities)
        .doc(university.id)
        .collection(keys.reviews)
        .get();

    for (var review in reviewsQuerySnapshot.docs) {
      Map<String, dynamic> reviewData = review.data();
      reviews.add(
        Review(
          id: reviewData[keys.id],
          userId: reviewData[keys.userId],
          universityId: reviewData[keys.universityId],
          addedAtInMilliSecondsSinceEpoch:
              reviewData[keys.addedAtInMilliSecondsSinceEpoch],
          average: (reviewData[keys.average] as num).toDouble(),
          professors: reviewData[keys.professors],
          lectures: reviewData[keys.lectures],
          equipment: reviewData[keys.equipment],
          freetimeActivities: reviewData[keys.freetimeActivities],
          internationality: review[keys.internationality],
        ),
      );
    }

    return reviews;
  }
}
