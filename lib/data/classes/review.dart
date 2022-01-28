class Review {
  final String? id;

  final String? userId;
  final String? universityId;
  final double? average;
  final int? professors;
  final int? lectures;
  final int? equipment;
  final int? freetimeActivities;
  final int? internationality;
  final int? addedAtInMilliSecondsSinceEpoch;

  Review({
    this.id,
    this.userId,
    this.universityId,
    this.average,
    this.professors,
    this.lectures,
    this.equipment,
    this.freetimeActivities,
    this.internationality,
    this.addedAtInMilliSecondsSinceEpoch,
  });
}
